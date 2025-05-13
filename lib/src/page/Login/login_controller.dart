import 'package:skinscanning/src/core/base_import.dart';

class LoginController extends BaseController with GetSingleTickerProviderStateMixin{
  final loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onTapForgotPassword(){
    Get.toNamed('/forgot');
  }

  void loginwithEmailandPassword() async{
    if(loginFormKey.currentState!.validate()){
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String? message = await Auth.to.loginUserEmailPassword(email, password);
      if (message == null){
        Get.snackbar('error', '');
      } else if (message.contains('Success')){
        Get.offAllNamed('/base');
      } else {
        Get.snackbar('', message);
      }
    }
  }

  void loginwithGoogle() async{
    String? message = await Auth.to.loginUserGoogle();
    if (message == null){
      Get.snackbar('error', '');
    } else if (message.contains('Success')){
      Get.offAllNamed('/base');
    } else {
      Get.snackbar('', message);
    }
  }

  void onTapSignUp() async{
    Get.toNamed('/register');
  }

  FormFieldValidator<String?> get emailValidator {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Email required';
      }
      if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
        return 'Enter a valid email';
      }
      return null;
    };
  }


  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() async {


    super.onReady();
  }

  @override
  void onClose() {
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