
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_me/features/auth/Screens/splashScreen.dart';
import 'package:save_me/features/home/provider/speed_dial_provider.dart';
import 'package:save_me/routes/app_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SpeedDialProvider(),
      child: const SaveMe(),
    ),
  );
}

class SaveMe extends StatelessWidget {
  const SaveMe({super.key});
  @override
  Widget build(BuildContext context) {

    AppRouter appRouter = AppRouter();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:  (BuildContext context,
          child){
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
