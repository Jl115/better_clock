import 'package:flutter/material.dart';

class StopwatchControls extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onReset;
  final VoidCallback onLap;

  const StopwatchControls({
    super.key,
    required this.isRunning,
    required this.onStart,
    required this.onStop,
    required this.onReset,
    required this.onLap,
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
            color: Colors.grey,
            onPressed: onReset,
          ),
          _ControlButton(
            label: isRunning ? 'Stop' : 'Start',
            color: isRunning ? Colors.red : Colors.green,
            onPressed: isRunning ? onStop : onStart,
          ),
          _ControlButton(
            label: 'Lap',
            color: Colors.indigo,
            onPressed: onLap,
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ControlButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(90, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
