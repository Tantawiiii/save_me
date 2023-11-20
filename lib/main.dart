import 'package:flutter/material.dart';
import 'package:save_me/features/auth/Screens/splashScreen.dart';

void main() {
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
      //theme:ThemeClass.lightTheme,
      home: SplashScreen(),
    );
  }
}
