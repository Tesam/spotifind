import 'package:flutter/material.dart';
import 'package:spotifind/services/services.dart';
import 'package:spotifind/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _response = 'Press record and play a song!';
  RecordingState _recordingState = RecordingState.idle;

  void _onRecordComplete(String? path) async {
    if (path != null) {
      final result = await VertexAIService.sendAudio(path);
      setState(() => _response = result ?? 'Music not found.');
    }
  }

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
              onRecordStart: () =>
                  setState(() => _recordingState = RecordingState.recording),
              onRecordStop: (path) {
                setState(() => _recordingState = RecordingState.stopped);
                _onRecordComplete(path);
              },
            ),
            const SizedBox(height: 32),
            Text(_response, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
