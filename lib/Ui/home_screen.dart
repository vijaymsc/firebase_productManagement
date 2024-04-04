import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/Ui/product/view/product_view.dart';
import 'package:product_management/Ui/user_auth/bloc_model/auth_bloc.dart';
import 'package:product_management/Ui/user_auth/bloc_model/auth_event.dart';
import 'package:product_management/Ui/user_auth/bloc_model/auth_state.dart';
import '../Constance/common_constance.dart';
import '../Route_page/route_constant.dart';
import '../custom_widget/custom_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(CommonConstance.background),
        centerTitle: true,
        title: const Text(
          "Welcome",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          top: false,
          bottom: true,
          child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is FailedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if (state is InitialSate) {
              Navigator.pushReplacementNamed(context, RoutePaths.loginUser);
            }
          }, builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    btnText: 'LogOut',
                    btnClick: () async {
                      context.read<AuthBloc>().add(LogOutEvent());
                    },
                  )
                ],
              ),
            );
          }),
        ),
      ),
      body: const ProductView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(CommonConstance.background),
        onPressed: () async {
          Navigator.pushNamed(context, RoutePaths.addProduct);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
