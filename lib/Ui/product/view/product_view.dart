import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_management/Route_page/route_constant.dart';
import 'package:product_management/Ui/product/view/product_details.dart';

import '../model/product_model.dart';
import '../view_model/database_services.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final DataBaseServices _dataBaseServices = DataBaseServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: StreamBuilder(
          stream: _dataBaseServices.getProduct(),
          builder: (context, snapshot) {
            List product = snapshot.data?.docs ?? [];
            if (product.isEmpty) {
              return const Center(
                child: Text("product is empty"),
              );
            }
            return ListView.separated(
              itemCount: product.length,
              //shrinkWrap: true,
              itemBuilder: (context, index) {
                ProductModel productList = product[index].data();
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.productDetails,
                        arguments: ProductData(product: productList));
                  },
                  child: Container(
                    //height: 50,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('productName: ${productList.productName}'),
                              Text(
                                  'measurement: ${productList.measurement.toString()}'),
                              Text('price: ${productList.price.toString()}'),
                            ],
                          ),
                        ),
                        Text(
                            '${DateFormat("dd-MM-yyyy h:mm a").format(productList.createdOn.toDate())}'),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5));
              },
            );
          }),
    ));
  }
}
