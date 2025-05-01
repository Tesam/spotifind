import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class FindButton extends StatelessWidget {
  const FindButton({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        depth: 3,
        intensity: 2,
        shape: NeumorphicShape.flat,
        boxShape: const NeumorphicBoxShape.circle(),
        shadowLightColor: const Color(0xFFFFFFFF).withAlpha(80),
      ),
      padding: const EdgeInsets.all(100),
      onPressed: () {},
      child: const Text(
        'Encontrar',
        style: TextStyle(fontSize: 36),
      ),
    );
  }
}
