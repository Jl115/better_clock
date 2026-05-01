import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stopwatch_bloc.dart';
import '../bloc/stopwatch_event.dart';
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
      body: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final duration = state.currentTotalDuration;
          final totalMs = duration.inMilliseconds;
          final minutes = (totalMs ~/ Duration.millisecondsPerMinute).toString().padLeft(2, '0');
          final seconds = ((totalMs % Duration.millisecondsPerMinute) ~/ Duration.millisecondsPerSecond)
              .toString()
              .padLeft(2, '0');
          final hundredths = ((totalMs % Duration.millisecondsPerSecond) ~/ 10).toString().padLeft(2, '0');

          final themeColor = Color(state.customization.accentColorHex);
          final digitalColor = Color(state.customization.digitColorHex);
          final fontSize = state.customization.digitFontSize;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Timer Display
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: fontSize,
                      fontWeight: FontWeight.w200,
                      color: digitalColor,
                    ),
                    children: [
                      TextSpan(text: '$minutes:$seconds.'),
                      TextSpan(
                        text: hundredths,
                        style: TextStyle(
                          fontSize: fontSize * 0.55,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Controls
              StopwatchControls(
                isRunning: state.isRunning,
                onStart: () => context.read<StopwatchBloc>().add(const StartStopwatch()),
                onStop: () => context.read<StopwatchBloc>().add(const StopStopwatch()),
                onReset: () => context.read<StopwatchBloc>().add(const ResetStopwatch()),
                onLap: () => context.read<StopwatchBloc>().add(const LapStopwatch()),
              ),
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
