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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF11114e),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  btnText: 'LogOut',
                  btnClick: () async {},
                )
              ],
            ),
          ),
        ),
      ),
      body: const ProductView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF11114e),
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
