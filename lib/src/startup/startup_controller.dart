import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/utils/auth_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StartupController extends BaseController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> fadeAnimation;


  @override
  void onInit() {
    animationController = AnimationController(duration: Duration(seconds: 2),vsync: this,);
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    super.onInit();
  }

  @override
  onReady() async {
    await Future.delayed(const Duration(seconds: 3));
    isLoading = true;
    FirebaseAuth auth = Auth.to.GetFireBaseAuth();
    final user = auth.currentUser;
    if (user != null) {
      await user.reload();
      final refreshedUser = auth.currentUser;
      final isLoggedIn = refreshedUser != null;
      isLoading = false;
      if (isLoggedIn) {
        Get.offAllNamed('/base');
      } else {
        Get.offAllNamed('/login');
      }
    } else {
      Get.offAllNamed('/login');
    }
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  Future<bool> onWillPop() async {
    return await onGoBack();
  }

  onGoBack() async {
    Get.back();
    return true;
  }
}