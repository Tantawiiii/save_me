// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:save_me/features/auth/Screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String language = "EN";
late Locale _locale;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((value) {
    if (value.getString("language") == null) {
      language = "EN";
      _locale = const Locale("EN");
    } else {
      language = value.getString("language") as String;
      _locale = Locale(value.getString("language")!.toLowerCase());
    }

    runApp(
      const SaveMe(),
    );
  });
}

class SaveMe extends StatefulWidget {
  const SaveMe({super.key});

  @override
  State<SaveMe> createState() => _SaveMeState();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _SaveMeState? state = context.findAncestorStateOfType<_SaveMeState>();
    state!.changeLanguage(newLocale);
  }

  static Locale getLocal(BuildContext context) {
    _SaveMeState? state = context.findAncestorStateOfType<_SaveMeState>();
    return state!.getLocal();
  }
}

class _SaveMeState extends State<SaveMe> {
  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale getLocal() {
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
