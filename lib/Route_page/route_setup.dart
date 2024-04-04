import 'package:flutter/material.dart';
import 'package:product_management/Route_page/route_constant.dart';

import '../Ui/home_screen.dart';
import '../Ui/product/view/add_product.dart';
import '../Ui/product/view/product_details.dart';
import '../Ui/product/view/product_view.dart';
import '../Ui/user_auth/view/register_view.dart';
import '../Ui/user_auth/view/setPin_view.dart';
import '../Ui/user_auth/view/user_login.dart';
import '../custom_widget/custom_widget.dart';

abstract class RouterViews {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case RoutePaths.loginUser:
          return MaterialPageRoute(builder: (_) => const LoginUser());

        case RoutePaths.register:
          return MaterialPageRoute(builder: (_) => const RegisterView());

        case RoutePaths.homeScreen:
          return MaterialPageRoute(builder: (_) => const HomeScreen());

        case RoutePaths.addProduct:
          return MaterialPageRoute(builder: (_) => const AddProduct());

        case RoutePaths.userPinLogin:
          return MaterialPageRoute(builder: (_) => const UserPinLogin());

        case RoutePaths.productView:
          return MaterialPageRoute(builder: (_) => const ProductView());

        case RoutePaths.productDetails:
          return MaterialPageRoute(
              builder: (_) => ProductDetails(
                    argument: settings.arguments as ProductData,
                  ));

        default:
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                      child: Text('No route defined for ${settings.name}'),
                    ),
                  ));
      }
    } catch (e) {
      showLog(e.toString());
    }
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
  }
}
