import 'package:flutter/material.dart';
import 'package:save_me/features/auth/Screens/login_screen.dart';
import 'package:save_me/features/auth/Screens/register_screen.dart';
import 'package:save_me/features/auth/Screens/splashScreen.dart';
import 'package:save_me/features/home/home_screen.dart';
import 'package:save_me/utils/constants/colors_code.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: ColorsCode.blackColor,
          onPrimary: ColorsCode.blackColor,
          secondary: Colors.black,
          onSecondary: Colors.grey,
          background: Colors.white,
          onBackground: Colors.grey,
          error: Colors.red,
          onError: ColorsCode.grayColor,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      home: const SplashScreen(),
      routes: {
        "/splash": (_) => const SplashScreen(),
        "/login": (_) => const LoginScreen(),
        "/register": (_) => const RegisterScreen(),
        "/home": (_) => const HomeScreen(),
      },
    );
  }
}
