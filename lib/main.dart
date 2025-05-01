import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:spotifind/firebase_options.dart';
import 'package:spotifind/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: NeumorphicThemeData(
        baseColor: Colors.white,
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF313030),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: FindButton()),
    );
  }
}
