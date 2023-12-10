
import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [

    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: Home.page),
    AutoRoute(page: Setting.page),
    AutoRoute(page: Profile.page),
    AutoRoute(page: Location.page),
    AutoRoute(page: CreatedProfile.page),
    AutoRoute(page: AddDisabledProfile.page),
    AutoRoute(page: AddSeniorProfile.page),
    AutoRoute(page: AddItemProfile.page),
    AutoRoute(page: AddKidProfile.page),
    AutoRoute(page: AddPetProfile.page),

  ];

}


/**
 * terminal for the router to generate
 * dart run build_runner build --delete-conflicting-outputs
 */