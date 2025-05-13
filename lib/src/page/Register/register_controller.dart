import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/utils/auth_utils.dart';

class RegisterController extends BaseController with GetSingleTickerProviderStateMixin{
  final registerFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  void registerWithEmailandPassword() async{
    if(registerFormKey.currentState!.validate()){
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String username = usernameController.text.trim();
      String? message = await Auth.to.registerUserEmailPassword(email,password,username);
      if (message == null){
        Get.snackbar('error', '');
      } else if (message.contains('Success')){
        Get.snackbar('Register Success','');
        Get.offAllNamed('/login');
      } else {
        Get.snackbar('', message);
      }
    }
  }

  void onTapSignIn() async{
    Get.offAllNamed('/login');
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