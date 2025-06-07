import 'dart:io';

import 'package:firebase_ai/firebase_ai.dart';

class VertexAIService {
  static Future<String?> sendAudio(String filePath) async {
    try {
      // Inicializa el modelo generativo
      final model =
          FirebaseAI.googleAI().generativeModel(model: 'gemini-2.0-flash');

      final prompt = TextPart("What musical genre is it?");

      // Lee el archivo de audio como bytes
      final audioBytes = await File(filePath).readAsBytes();

      // Proporciona el audio como `Data` con el tipo MIME de audio apropiado
      final audioPart = InlineDataPart('audio/mpeg', audioBytes);

      // Para generar salida de texto, llama `generateContent` con el texto 
      // y audio
      final response = await model.generateContent([
        Content.multi([prompt, audioPart])
      ]);

      // Extrae la respuesta de texto
      final text = response.text?.trim();

      // Devuelve el resultado o un mensaje por defecto
      return (text != null && text.isNotEmpty) ? text : 'Music not found.';
    } catch (e) {
      return 'Music not found.';
    }
  }
}
