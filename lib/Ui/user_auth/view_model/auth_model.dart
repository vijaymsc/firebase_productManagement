import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../Constance/sharedPrefrence_constance.dart';
import '../../../custom_widget/custom_widget.dart';
import '../../../shared_prefrance/shared_prefrance_helper.dart';

class UserAuthModel {
  ///Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///create user
  Future<User?> createUser(String userEmail, password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      showLog(e.code);
    }
    return null;
  }

  ///login user
  Future<User?> loginUser(String userEmail, password) async {
    try {
      print('userEmail::$userEmail:::$password');
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: password);
      PreferenceHelper.setBool(PreferenceConstant.userLoginStatus, true);
      PreferenceHelper.setString(
          PreferenceConstant.userLoginId, credential.user!.email!);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      //  loginErrorMsg = e.message!;
      showLog(e.code!);
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
      showLog(e.code!);
    }
    return false;
  }
}
