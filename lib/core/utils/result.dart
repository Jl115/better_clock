/// A generic monadic Result wrapper for error handling.
/// Uses OOP class hierarchy instead of exceptions.
sealed class Result<T, E> {
  const Result();

  bool get isSuccess => this is Success<T, E>;
  bool get isFailure => this is Failure<T, E>;

  T? get value => switch (this) {
        Success<T, E>(:final value) => value,
        Failure<T, E>() => null,
      };

  E? get error => switch (this) {
        Success<T, E>() => null,
        Failure<T, E>(:final error) => error,
      };

  R when<R>({
    required R Function(T value) success,
    required R Function(E error) failure,
  }) =>
      switch (this) {
        Success<T, E>(:final value) => success(value),
        Failure<T, E>(:final error) => failure(error),
      };
}

final class Success<T, E> extends Result<T, E> {
  @override
  final T value;
  const Success(this.value);

  @override
  String toString() => 'Success($value)';
}

final class Failure<T, E> extends Result<T, E> {
  @override
  final E error;
  const Failure(this.error);

  @override
  String toString() => 'Failure($error)';
}

/// Standard application-level errors.
sealed class AppError {
  final String message;
  const AppError(this.message);

  @override
  String toString() => message;
}

final class DatabaseError extends AppError {
  const DatabaseError(super.message);
}

final class NotFoundError extends AppError {
  const NotFoundError(super.message);
}

final class ValidationError extends AppError {
  const ValidationError(super.message);
}

final class UnknownError extends AppError {
  final Object? cause;
  const UnknownError(super.message, {this.cause});
}

extension DurationFormatting on Duration {
  /// Formats a stopwatch-style duration as MM:SS.hs or HH:MM:SS.hs.
  String formatStopwatch({bool alwaysShowHours = false}) {
    final totalMs = inMilliseconds;
    final hours = totalMs ~/ Duration.millisecondsPerHour;
    final minutes = (totalMs % Duration.millisecondsPerHour) ~/
        Duration.millisecondsPerMinute;
    final seconds = (totalMs % Duration.millisecondsPerMinute) ~/
        Duration.millisecondsPerSecond;
    final hundredths = (totalMs % Duration.millisecondsPerSecond) ~/ 10;

    final minStr = minutes.toString().padLeft(2, '0');
    final secStr = seconds.toString().padLeft(2, '0');
    final hunStr = hundredths.toString().padLeft(2, '0');

    if (hours > 0 || alwaysShowHours) {
      return '${hours.toString().padLeft(2, '0')}:$minStr:$secStr.$hunStr';
    }
    return '$minStr:$secStr.$hunStr';
  }
}

extension DateTimeExtensions on DateTime {
  DateTime withTime(int hour, int minute, {int second = 0, int millisecond = 0}) {
    return DateTime(
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
    );
  }
}
