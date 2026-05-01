import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/catppuccin_colors.dart';
import '../bloc/stopwatch_bloc.dart';
import '../bloc/stopwatch_event.dart';

class StopwatchControls extends StatelessWidget {
  final bool isRunning;

  const StopwatchControls({
    super.key,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ControlButton(
            label: 'Reset',
            backgroundColor: CatppuccinMocha.surface2,
            foregroundColor: CatppuccinMocha.text,
            onPressed: () =>
                context.read<StopwatchBloc>().add(const ResetStopwatch()),
          ),
          _ControlButton(
            label: isRunning ? 'Stop' : 'Start',
            backgroundColor:
                isRunning ? CatppuccinMocha.red : CatppuccinMocha.green,
            foregroundColor: CatppuccinMocha.crust,
            onPressed: () => isRunning
                ? context.read<StopwatchBloc>().add(const StopStopwatch())
                : context.read<StopwatchBloc>().add(const StartStopwatch()),
          ),
          _ControlButton(
            label: 'Lap',
            backgroundColor: CatppuccinMocha.blue,
            foregroundColor: CatppuccinMocha.crust,
            onPressed: () =>
                context.read<StopwatchBloc>().add(const LapStopwatch()),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  const _ControlButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: const Size(90, 50),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
