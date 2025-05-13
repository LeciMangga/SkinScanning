import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/utils/index.dart';

class ForgotPasswordController extends BaseController with GetSingleTickerProviderStateMixin{
  final emailResetKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

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

  void onPressedResetButton() async {
    final email = emailController.text.trim();
    final message = await Auth.to.forgotPassword(email);
    if (message == null){
      Get.snackbar('error', 'null');
    }else {
      Get.snackbar('message', message);
    }
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