import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product_management/Ui/user_auth/view/setPin_view.dart';
import 'package:product_management/Ui/user_auth/view/user_login.dart';
import '../shared_prefrance/shared_preference_const.dart';
import '../shared_prefrance/shared_prefrance_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userLoginStatus = false;
  @override
  void initState() {
    checkUserLogin();
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      _navigateScreen();
    });
    // TODO: implement initState
    super.initState();
  }

  checkUserLogin() async {
    userLoginStatus =
        await PreferenceHelper.getBool(PreferenceConstant.userLoginStatus);
  }

  _navigateScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => userLoginStatus ? const UserPinLogin() : const LoginUser(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 3),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Image.asset('assets/splash_scree.png'),
                  );
                })
          ],
        ),
      ),
    );
  }
}
