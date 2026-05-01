import 'dart:async';

/// Singleton service that emits a [DateTime] tick every interval.
/// Used by stopwatch, timer, and live clock faces.
class TimeTickerService {
  static final TimeTickerService _instance = TimeTickerService._internal();
  factory TimeTickerService() => _instance;
  TimeTickerService._internal();

  Timer? _timer;
  final _controller = StreamController<DateTime>.broadcast();

  Stream<DateTime> get tickStream => _controller.stream;

  void start({Duration interval = const Duration(milliseconds: 10)}) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) {
      _controller.add(DateTime.now());
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
    _controller.close();
  }
}
