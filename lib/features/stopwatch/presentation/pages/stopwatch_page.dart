import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/catppuccin_colors.dart';
import '../bloc/stopwatch_bloc.dart';
import '../bloc/stopwatch_state.dart';
import '../widgets/stopwatch_controls.dart';
import '../widgets/stopwatch_lap_list.dart';

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
        centerTitle: true,
      ),
      backgroundColor: CatppuccinMocha.base,
      body: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: CatppuccinMocha.lavender,
              ),
            );
          }

          final duration = state.currentTotalDuration;
          final totalMs = duration.inMilliseconds;
          final minutes = (totalMs ~/ Duration.millisecondsPerMinute)
              .toString()
              .padLeft(2, '0');
          final seconds =
              ((totalMs % Duration.millisecondsPerMinute) ~/
                      Duration.millisecondsPerSecond)
                  .toString()
                  .padLeft(2, '0');
          final hundredths =
              ((totalMs % Duration.millisecondsPerSecond) ~/ 10)
                  .toString()
                  .padLeft(2, '0');
          final fontSize = state.customization.digitFontSize;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: CatppuccinMocha.crust,
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: fontSize,
                        fontWeight: FontWeight.w200,
                        color: CatppuccinMocha.text,
                      ),
                      children: [
                        TextSpan(text: '$minutes:$seconds.'),
                        TextSpan(
                          text: hundredths,
                          style: TextStyle(
                            fontSize: fontSize * 0.55,
                            color: CatppuccinMocha.lavender,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Controls
              StopwatchControls(isRunning: state.isRunning),
              const SizedBox(height: 16),
              // Lap List
              if (state.customization.showLapList)
                StopwatchLapList(laps: state.session?.laps ?? const []),
            ],
          );
        },
      ),
    );
  }
}
