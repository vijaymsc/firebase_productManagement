import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Route_page/route_constant.dart';
import '../../../custom_widget/custom_widget.dart';
import '../../home_screen.dart';
import '../bloc_model/auth_bloc.dart';
import '../bloc_model/auth_event.dart';
import '../bloc_model/auth_state.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userRePasswordController =
      TextEditingController();

  @override
  void deactivate() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userRePasswordController.dispose();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is FailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        if (state is SuccessSate) {
          Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
        }
      }, builder: (context, state) {
        // if (state is FailedState) {
        //   return Text(state.errorMessage);
        // }
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
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
                    "Create your Account",
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
                              formFieldController: _userEmailController,
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
                            formFieldController: _userPasswordController,
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
                          CustomTextFormField(
                            formFieldController: _userRePasswordController,
                            hintTextValue: "enter your Re-password",
                            inputType: TextInputType.visiblePassword,
                            suffixIcon: true,
                            validatorFunc: (value) {
                              if (value == null || value.isEmpty) {
                                return "Re-password not empty...";
                              } else if (value !=
                                  _userPasswordController.text) {
                                return "Re-enter password should be same";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            btnText: 'Register',
                            isLoading: state is LoadingState ? true : false,
                            btnClick: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(RegisterEvent(
                                    userEmail: _userEmailController.text,
                                    password: _userPasswordController.text));
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutePaths.loginUser);
                                },
                                child: const Text(
                                  'Already have account?',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
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
    );
  }
}
