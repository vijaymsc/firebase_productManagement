import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Route_page/route_constant.dart';
import '../../../custom_widget/custom_widget.dart';
import '../../../shared_prefrance/shared_preference_const.dart';
import '../../../shared_prefrance/shared_prefrance_helper.dart';
import '../bloc_model/auth_bloc.dart';
import '../bloc_model/auth_event.dart';
import '../bloc_model/auth_state.dart';

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

  String userEmail = '';
  bool? userLoginStatus = false;
  bool? isPinSetOrNot = false;

  checkUserLogin() async {
    userEmail =
        await PreferenceHelper.getString(PreferenceConstant.userLoginId);
    userLoginStatus =
        await PreferenceHelper.getBool(PreferenceConstant.userLoginStatus);
    isPinSetOrNot =
        await PreferenceHelper.getBool(PreferenceConstant.isPinSetOrNot);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    checkUserLogin();
    super.initState();
  }

  clearData() {
    pinController1.clear();
    pinController2.clear();
    pinController3.clear();
    pinController4.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is FailedState) {
            clearData();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if (state is AuthPinSuccessSate) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.successStatus)));
            Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
          }
          if (state is InitialSate) {
            Navigator.pushReplacementNamed(context, RoutePaths.loginUser);
          }
        }, builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return Padding(
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
                        Text(
                          isPinSetOrNot!
                              ? 'Enter ProductApp Pin'
                              : 'Set ProductApp Pin',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          userEmail,
                          style: const TextStyle(
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
                        ),
                        isPinSetOrNot!
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap: () {
                                        context
                                            .read<AuthBloc>()
                                            .add(LogOutEvent());
                                      },
                                      child: const Text(
                                        'Forgot Pin or Logout',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ))
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                  CustomButton(
                    btnText: isPinSetOrNot! ? 'Verify' : 'Set Pin',
                    btnClick: () {
                      if (_formKey.currentState!.validate()) {
                        int pin = getSinglePin();
                        if (isPinSetOrNot!) {
                          context
                              .read<AuthBloc>()
                              .add(SeVerifyAuthPin(verifyAuthPin: pin));
                        } else {
                          context
                              .read<AuthBloc>()
                              .add(SetAuthPin(userAuthPin: pin));
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  int getSinglePin() {
    String data = pinController1.text +
        pinController2.text +
        pinController3.text +
        pinController4.text;
    int pin = int.parse(data);
    return pin;
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
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                      1), // Limits input to 1 character
                ],
                decoration: userPinInputBox(),
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
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                      1), // Limits input to 1 character
                ],
                decoration: userPinInputBox(),
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
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                      1), // Limits input to 1 character
                ],
                decoration: userPinInputBox(),
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
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                      1), // Limits input to 1 character
                ],
                decoration: userPinInputBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
