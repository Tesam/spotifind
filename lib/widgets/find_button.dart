import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:spotifind/services/services.dart';

enum RecordingState {
  idle,
  recording,
  stopped,
}

class FindButton extends StatefulWidget {
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
  State<FindButton> createState() => _FindButtonState();
}

class _FindButtonState extends State<FindButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(FindButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.recordingState == RecordingState.recording) {
      _animationController.repeat();
    } else {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = switch (widget.recordingState) {
      RecordingState.idle => 'Grabar',
      RecordingState.recording => 'Parar',
      RecordingState.stopped => 'Analizando',
    };

    return Stack(
      alignment: Alignment.center,
      children: [
        if (widget.recordingState == RecordingState.recording)
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(270, 270),
                painter: _ProgressPainter(_animationController.value),
              );
            },
          ),
        NeumorphicButton(
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
        ),
      ],
    );
  }

  void toggleRecording() async {
    if (widget.recordingState == RecordingState.stopped ||
        widget.recordingState == RecordingState.idle) {
      await AudioService.startRecording();
      widget.onRecordStart();
    } else {
      final path = await AudioService.stopRecording();
      widget.onRecordStop(path);
    }
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;

  _ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708, // Start from top (-90 degrees)
      2 * 3.14159 * progress, // Progress in radians
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
