import 'package:get/get.dart';
import 'package:skinscanning/src/bindings/index.dart';
import 'package:skinscanning/src/bindings/landing_binding.dart';
import 'package:skinscanning/src/page/Landing/landing_controller.dart';
import 'package:skinscanning/src/startup/startup_view.dart';
import 'package:skinscanning/src/page/Landing/landing_view.dart';
import 'package:skinscanning/src/page/Login/login_view.dart';
import 'package:skinscanning/src/page/Register/register_view.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => StartupView(),
      binding: StartupBinding(),
    ),
    GetPage(
      name: '/landing',
      page: () => LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
  ];
}