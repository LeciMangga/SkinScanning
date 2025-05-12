import 'package:firebase_auth/firebase_auth.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends BaseController{

  static Auth get to => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  FirebaseAuth GetFireBaseAuth(){
    return _auth;
  }

  @override
  void onInit(){
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  Future<String?> registerUserEmailPassword(String email,password)async{
    try{
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return "Success";
    }on FirebaseAuthException catch (e){
      if (e.code == 'weak-password'){
        return 'The Password provided is too weak';
      } else if(e.code == 'email-already-in-use'){
        return 'The account already exists for that email';
      }
    } catch (e){
      return e.hashCode.toString();
    }
    return null;
  }

  Future<String?> loginUserEmailPassword(String email,password)async{
    try{
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        firebaseUser.value = credential.user;
        SettingsUtils.setString('uid', credential.user!.uid);
        SettingsUtils.setString('email', credential.user!.email);
        SettingsUtils.setString('display-name', credential.user!.displayName);
        SettingsUtils.setString('photoURL', credential.user!.photoURL);
        return 'Success';
      } else {
        return 'Login failed';
      }
    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.code.toString();
      }
    }catch (e){
      return e.toString();
    }
  }


  Future<dynamic> loginUserGoogle()async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final credentialg = await _auth.signInWithCredential(credential);
      firebaseUser.value = credentialg.user;
      return 'Success';
    }on Exception catch(e){
      return e.toString();
    }
  }

  Future<bool> signInCredential(AuthCredential credential)async{
    try{
      final userCredential = await _auth.signInWithCredential(credential);
      firebaseUser.value = userCredential.user;
      return true;
    }on FirebaseAuthException catch (e){
      return false;
    } catch (e){
      return false;
    }
  }


}