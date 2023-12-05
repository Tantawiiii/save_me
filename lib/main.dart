// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:save_me/features/auth/Screens/splashScreen.dart';
import 'package:save_me/routes/app_router.dart';

void main() {
  runApp(
    const SaveMe(),
  );
}

class SaveMe extends StatelessWidget {
  const SaveMe({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // localization english and german
      // translations: Translation(),
      // locale: const Locale('en'),
      // fallbackLocale: const Locale('en'),

      locale: Locale('en'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('de'), // Germany
      ],
    );
  }
}
