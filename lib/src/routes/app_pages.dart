import 'package:get/get.dart';
import 'package:skinscanning/src/bindings/base_builder_binding.dart';
import 'package:skinscanning/src/bindings/forgot_password_binding.dart';
import 'package:skinscanning/src/bindings/index.dart';
import 'package:skinscanning/src/bindings/base_builder_binding.dart';
import 'package:skinscanning/src/page/ForgotPassword/forgot_password_view.dart';
import 'package:skinscanning/src/page/ScanUrSkin/ScanUrSkin_view.dart';
import 'package:skinscanning/src/page/Template/base_Builder.dart';
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
      name: '/base',
      page: () => BaseBuilder(),
      binding: BaseBuilderBinding(),
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
    GetPage(
      name: '/forgot',
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}