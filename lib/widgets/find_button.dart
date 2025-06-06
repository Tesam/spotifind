import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:spotifind/services/services.dart';

enum RecordingState {
  idle,
  recording,
  stopped,
}

class FindButton extends StatelessWidget {
  const FindButton({
    super.key,
    required this.recordingState,
    required this.onRecordStart,
    required this.onRecordStop,
  });

  final RecordingState recordingState;
  final VoidCallback onRecordStart;
  final ValueChanged<String?> onRecordStop;

  @override
  Widget build(BuildContext context) {
    final text = switch (recordingState) {
      RecordingState.idle => 'Grabar',
      RecordingState.recording => 'Parar',
      RecordingState.stopped => 'Analizando',
    };

    return NeumorphicButton(
      style: NeumorphicStyle(
        depth: 3,
        intensity: 2,
        shape: NeumorphicShape.flat,
        boxShape: const NeumorphicBoxShape.circle(),
        shadowLightColor: const Color(0xFFFFFFFF).withAlpha(80),
      ),
      padding: const EdgeInsets.all(100),
      onPressed: () => toggleRecording(),
      child: Text(
        text,
        style: const TextStyle(fontSize: 36),
      ),
    );
  }

  void toggleRecording() async {
    if (recordingState == RecordingState.stopped ||
        recordingState == RecordingState.idle) {
      await AudioService.startRecording();
      onRecordStart();
    } else {
      final path = await AudioService.stopRecording();
      onRecordStop(path);
    }
  }
}
