import 'package:flutter/material.dart';
import 'package:spotifind/services/services.dart';
import 'package:spotifind/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String response = '';
  RecordingState recordingState = RecordingState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spotifind')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FindButton(
              recordingState: recordingState,
              onRecordStart: onRecordStart,
              onRecordStop: (path) {
                setState(() => recordingState = RecordingState.stopped);
                onRecordComplete(path);
              },
            ),
            const SizedBox(height: 32),
            if (response.isNotEmpty)
              Chip(
                label: Text(
                  response,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onRecordStart() {
    setState(() {
      recordingState = RecordingState.recording;
      response = '';
    });
  }

  void onRecordComplete(String? path) async {
    if (path != null) {
      final result = await VertexAIService.sendAudio(path);
      setState(() {
        response = result ?? 'Musica no encontrada';
        recordingState = RecordingState.idle;
      });
    }
  }
}
