/// Singleton audio service wrapping audioplayers.
/// Handles playback of default and custom alarm / stopwatch sounds.
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    // TODO: Setup AudioPlayer instances, set release mode
  }

  Future<void> playAlarm({String? customUri, double volume = 1.0}) async {
    // TODO: Play default or custom sound, looping
  }

  Future<void> playClick() async {
    // TODO: Subtle click for stopwatch lap
  }

  Future<void> stop() async {
    // TODO: Stop all players
  }

  Future<void> setVolume(double volume) async {
    // TODO: Set player volume
  }

  void dispose() {
    // TODO: Release players
  }
}
