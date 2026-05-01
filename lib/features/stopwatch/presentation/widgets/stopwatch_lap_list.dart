import 'package:flutter/material.dart';

import '../../../../core/theme/catppuccin_colors.dart';
import '../../domain/entities/stopwatch_lap.dart';

class StopwatchLapList extends StatelessWidget {
  final List<StopwatchLap> laps;

  const StopwatchLapList({super.key, required this.laps});

  @override
  Widget build(BuildContext context) {
    if (laps.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            'No laps recorded',
            style: TextStyle(color: CatppuccinMocha.overlay0),
          ),
        ),
      );
    }

    final reversed = laps.reversed.toList();

    return Expanded(
      child: ListView.separated(
        reverse: false,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: reversed.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: CatppuccinMocha.surface1,
        ),
        itemBuilder: (context, index) {
          final lap = reversed[index];
          return _LapRow(
            lapNumber: lap.lapNumber,
            lapDuration: lap.lapDuration,
            totalDuration: lap.totalDuration,
          );
        },
      ),
    );
  }
}

class _LapRow extends StatelessWidget {
  final int lapNumber;
  final Duration lapDuration;
  final Duration totalDuration;

  const _LapRow({
    required this.lapNumber,
    required this.lapDuration,
    required this.totalDuration,
  });

  String _fmt(Duration d) {
    final totalMs = d.inMilliseconds;
    final minutes =
        (totalMs ~/ Duration.millisecondsPerMinute).toString().padLeft(2, '0');
    final seconds =
        ((totalMs % Duration.millisecondsPerMinute) ~/
                Duration.millisecondsPerSecond)
            .toString()
            .padLeft(2, '0');
    final hundredths =
        ((totalMs % Duration.millisecondsPerSecond) ~/ 10)
            .toString()
            .padLeft(2, '0');
    return '$minutes:$seconds.$hundredths';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              '#$lapNumber',
              style: const TextStyle(
                fontSize: 16,
                color: CatppuccinMocha.overlay0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              _fmt(lapDuration),
              style: const TextStyle(
                fontSize: 16,
                color: CatppuccinMocha.text,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            _fmt(totalDuration),
            style: const TextStyle(
              fontSize: 16,
              color: CatppuccinMocha.subtext0,
            ),
          ),
        ],
      ),
    );
  }
}
