import 'package:flutter/material.dart';
import 'package:product_management/Ui/product/view/product_view.dart';
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
        title: const Text("welcome"),
      ),
      drawer: Drawer(
        child: SafeArea(
          top: false,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  btnText: 'LogOut',
                  btnClick: () async {
                    // bool status = await model.logOut();
                    // if (status && mounted) {
                    //   showSnackBarNew(context, "LogOut Successfully");
                    //   Navigator.pushReplacementNamed(
                    //       context, RoutePaths.loginUser);
                    // } else {
                    //   showSnackBarNew(context, "LogOut Failed");
                    // }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: const ProductView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, RoutePaths.addProduct);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
