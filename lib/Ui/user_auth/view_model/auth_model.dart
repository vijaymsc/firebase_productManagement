import 'package:firebase_auth/firebase_auth.dart';
import '../../../custom_widget/custom_widget.dart';
import '../../../shared_prefrance/shared_preference_const.dart';
import '../../../shared_prefrance/shared_prefrance_helper.dart';

class UserAuthModel {
  ///Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///create user
  Future<User?> createUser(String userEmail, password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: password);
      PreferenceHelper.setBool(PreferenceConstant.userLoginStatus, true);
      PreferenceHelper.setString(
          PreferenceConstant.userLoginId, credential.user!.email!);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      showLog(e.code);
    }
    return null;
  }

  ///login user
  Future<User?> loginUser(String userEmail, password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: password);
      PreferenceHelper.setBool(PreferenceConstant.userLoginStatus, true);
      PreferenceHelper.setString(
          PreferenceConstant.userLoginId, credential.user!.email!);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      showLog(e.code);
    }
    return null;
  }

  ///logout user
  Future<bool> logOut() async {
    try {
      _auth.signOut();
      PreferenceHelper.clearPreference();
      return true;
    } on FirebaseAuthException catch (e) {
      showLog(e.code);
    }
    return false;
  }

  ///set UserPine
  Future<bool> setAuthPin(int userAuthPin) async {
    try {
      await PreferenceHelper.setBool(PreferenceConstant.isPinSetOrNot, true);
      await PreferenceHelper.setInt(
          PreferenceConstant.userAuthPin, userAuthPin);
      return true;
    } catch (e) {
      showLog(e.toString());
    }
    return false;
  }

  ///verify Pin
  Future<bool> verifyPin(int verifyPin) async {
    try {
      var isPinSetOrNot =
          await PreferenceHelper.getBool(PreferenceConstant.isPinSetOrNot);
      var userAuthPin =
          await PreferenceHelper.getInt(PreferenceConstant.userAuthPin);
      if (isPinSetOrNot && userAuthPin == verifyPin) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      showLog(e.toString());
    }
    return false;
  }
}
