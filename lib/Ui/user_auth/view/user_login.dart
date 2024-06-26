import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Constance/common_constance.dart';
import '../../../Route_page/route_constant.dart';
import '../../../custom_widget/custom_widget.dart';
import '../bloc_model/auth_bloc.dart';
import '../bloc_model/auth_event.dart';
import '../bloc_model/auth_state.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void deactivate() {
    // TODO: implement deactivate
    _emailController.dispose();
    _passwordController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is FailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if (state is SuccessSate) {
            Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
          }
        }, builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/splash_scree.png')),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                                formFieldController: _emailController,
                                hintTextValue: "enter your email",
                                inputType: TextInputType.emailAddress,
                                validatorFunc: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "user email not empty...";
                                  } else if (!value.contains("@")) {
                                    return "enter a valid email...";
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              formFieldController: _passwordController,
                              hintTextValue: "enter your password",
                              inputType: TextInputType.visiblePassword,
                              suffixIcon: true,
                              validatorFunc: (value) {
                                if (value == null || value.isEmpty) {
                                  return "password not empty...";
                                } else if (value.length <= 5) {
                                  return "password  should be minimum 6 character...";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              btnText: 'Login',
                              // isLoading:
                              //value.btnLoading,
                              btnClick: () async {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(LoginEvent(
                                        userEmail: _emailController.text,
                                        password: _passwordController.text,
                                      ));
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutePaths.register);
                                  },
                                  child: const Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Forget Password?',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        color:
                                            Color(CommonConstance.background)),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
