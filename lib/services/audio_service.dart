import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioService {
  static final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (!_isInitialized) {
      await Permission.microphone.request();
      await _recorder.openRecorder();
      _isInitialized = true;
    }
  }

  static Future<String?> startRecording() async {
    await init();
    const path = 'spotifind_record.aac';
    await _recorder.startRecorder(toFile: path, codec: Codec.aacADTS);
    return path;
  }

  static Future<String?> stopRecording() async {
    return await _recorder.stopRecorder();
  }
}
