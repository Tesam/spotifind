import 'package:flutter/material.dart';
import 'package:spotifind/services/services.dart';
import 'package:spotifind/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _response = '';
  RecordingState _recordingState = RecordingState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spotifind')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FindButton(
              recordingState: _recordingState,
              onRecordStart: onRecordStart,
              onRecordStop: (path) {
                setState(() => _recordingState = RecordingState.stopped);
                onRecordComplete(path);
              },
            ),
            const SizedBox(height: 32),
            Text(_response, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  void onRecordStart() {
    setState(() {
      _recordingState = RecordingState.recording;
      _response = '';
    });
  }

  void onRecordComplete(String? path) async {
    if (path != null) {
      final result = await VertexAIService.sendAudio(path);
      setState(() {
        _response = result ?? 'Musica no encontrada';
        _recordingState = RecordingState.idle;
      });
    }
  }
}
