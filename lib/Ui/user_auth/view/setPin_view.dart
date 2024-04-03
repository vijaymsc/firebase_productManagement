import 'package:flutter/material.dart';

import '../../../custom_widget/custom_widget.dart';

class UserPinLogin extends StatefulWidget {
  const UserPinLogin({super.key});

  @override
  State<UserPinLogin> createState() => _UserPinLoginState();
}

class _UserPinLoginState extends State<UserPinLogin> {
  final TextEditingController pinController1 = TextEditingController();
  final TextEditingController pinController2 = TextEditingController();
  final TextEditingController pinController3 = TextEditingController();
  final TextEditingController pinController4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 25, bottom: 10, left: 13, right: 13),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset('assets/splash_scree.png')),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Set ProductApp Pin',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'user email',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      _setPinView(
                        first: pinController1,
                        second: pinController2,
                        third: pinController3,
                        fourth: pinController4,
                        keyEmailOtp: _formKey,
                      )
                    ],
                  ),
                ),
                CustomButton(
                  btnText: 'Set Pin',
                  btnClick: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _setPinView(
      {required GlobalKey<FormState> keyEmailOtp,
      required TextEditingController first,
      required TextEditingController second,
      required TextEditingController third,
      required TextEditingController fourth}) {
    return Form(
      key: keyEmailOtp,
      child: AutofillGroup(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 60,
              width: 58,
              child: TextFormField(
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return '';
                  }
                  return null;
                },
                autofocus: true,
                controller: first,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: userPinInputBox(),
                // inputFormatters: [
                //   LengthLimitingTextInputFormatter(1),
                //   FilteringTextInputFormatter.digitsOnly
                // ],
              ),
            ),
            SizedBox(
              height: 60,
              width: 58,
              child: TextFormField(
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  } else {
                    FocusScope.of(context).previousFocus();
                  }
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return '';
                  }
                  return null;
                },
                controller: second,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: userPinInputBox(),
                inputFormatters: [
                  // LengthLimitingTextInputFormatter(1),
                  // FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            SizedBox(
              height: 60,
              width: 58,
              child: TextFormField(
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  } else {
                    FocusScope.of(context).previousFocus();
                  }
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return '';
                  }
                  return null;
                },
                controller: third,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: userPinInputBox(),
                inputFormatters: [
                  // LengthLimitingTextInputFormatter(1),
                  // FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            SizedBox(
              height: 60,
              width: 58,
              child: TextFormField(
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  } else {
                    FocusScope.of(context).previousFocus();
                  }
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return '';
                  }
                  return null;
                },
                controller: fourth,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: userPinInputBox(),
                inputFormatters: [
                  // LengthLimitingTextInputFormatter(1),
                  // FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration userPinInputBox() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.fromLTRB(5.0 * 2, 5.0 * 2, 5.0 * 2, 5.0 * 2),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: Color(0xFF11114e)),
        borderRadius: BorderRadius.circular(4)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2,
          color: Color(0xFF11114e),
        ),
        borderRadius: BorderRadius.circular(4)),
    border: OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(4)),
  );
}
