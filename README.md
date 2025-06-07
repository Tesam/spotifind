# Spotifind

Spotifind is a Flutter application that allows users to record audio, send it to a Vertex AI agent using Firebase AI Logic, and receive the genre of the music in the recording or a default message if the music is not found.

## Features

- Record audio using the device's microphone (`flutter_sound`)
- Send recorded audio to Vertex AI via Firebase AI Logic (`firebase_ai`)
- Display the detected music genre or a default "not found" message

## Project Structure

```
lib/
├── main.dart
├── screens/
│   └── home_screen.dart
├── services/
│   ├── audio_service.dart
│   └── vertexai_service.dart
└── widgets/
    └── record_button.dart
```

## Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone <repository-url>
   cd spotifind
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Configure Firebase:**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the appropriate directories.
   - Set up Firebase in your project as described in the [FlutterFire documentation](https://firebase.flutter.dev/docs/overview).

4. **Configure Vertex AI:**
   - Enable Vertex AI and AI Logic in your Firebase project.
   - Follow the [Firebase AI Logic setup guide](https://firebase.google.com/docs/ai-logic/get-started?hl=es-419&api=dev).
   - Update `vertexai_service.dart` with your model and configuration.

5. **Run the app:**
   ```sh
   flutter run
   ```

## Usage

- Open the app.
- Tap the record button to start recording music.
- Tap again to stop and send the audio to Vertex AI.
- The app will display the detected music genre or "Music not found."

## Dependencies

- [`flutter_sound`](https://pub.dev/packages/flutter_sound): Audio recording
- [`firebase_vertexai`](https://pub.dev/packages/firebase_ai): Vertex AI integration
- [`firebase_core`](https://pub.dev/packages/firebase_core): Firebase core
- [`permission_handler`](https://pub.dev/packages/permission_handler): Microphone permissions
- [`flutter_neumorphic_plus`](https://pub.dev/packages/flutter_neumorphic_plus): UI styling