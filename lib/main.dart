import 'package:flutter/material.dart';
import 'package:save_me/src/features/home/screens/home_screen.dart';

void main() => runApp(const SaveMe());

class SaveMe extends StatelessWidget {
  const SaveMe({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home:  HomePage(),
    );
  }
}

