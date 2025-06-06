import 'dart:io';

import 'package:firebase_ai/firebase_ai.dart';

class VertexAIService {
  static Future<String?> sendAudio(String filePath) async {
    try {
      // Initialize the generative model (replace with your model name if needed)
      final model =
          FirebaseAI.googleAI().generativeModel(model: 'gemini-2.0-flash');

      final prompt = TextPart("What musical genre is it?");

      // Read the audio file as bytes
      final audioBytes = await File(filePath).readAsBytes();

      // Provide the audio as `Data` with the appropriate audio MIME type
      final audioPart = InlineDataPart('audio/mpeg', audioBytes);

      // To generate text output, call `generateContent` with the text and audio
      final response = await model.generateContent([
        Content.multi([prompt, audioPart])
      ]);

      // Extract the text response
      final text = response.text?.trim();

      // Return the result or a default message
      return (text != null && text.isNotEmpty) ? text : 'Music not found.';
    } catch (e) {
      return 'Music not found.';
    }
  }
}
