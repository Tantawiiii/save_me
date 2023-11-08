import 'package:flutter/material.dart';
import 'package:save_me/features/auth/Screens/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const SaveMe(),

  );

}

class SaveMe extends StatelessWidget {
  const SaveMe({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
