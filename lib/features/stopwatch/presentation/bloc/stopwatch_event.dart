import '../../domain/entities/stopwatch_customization.dart';

sealed class StopwatchEvent {
  const StopwatchEvent();
}

class LoadStopwatch extends StopwatchEvent {
  const LoadStopwatch();
}

class StartStopwatch extends StopwatchEvent {
  const StartStopwatch();
}

class StopStopwatch extends StopwatchEvent {
  const StopStopwatch();
}

class ResetStopwatch extends StopwatchEvent {
  const ResetStopwatch();
}

class LapStopwatch extends StopwatchEvent {
  const LapStopwatch();
}

class TickStopwatch extends StopwatchEvent {
  final DateTime now;
  const TickStopwatch(this.now);
}

class LoadCustomization extends StopwatchEvent {
  const LoadCustomization();
}

class UpdateCustomization extends StopwatchEvent {
  final StopwatchCustomization customization;
  const UpdateCustomization(this.customization);
}
