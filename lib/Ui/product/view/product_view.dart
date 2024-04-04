import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:product_management/Route_page/route_constant.dart';
import 'package:product_management/Ui/product/view/product_details.dart';

import '../../../Constance/common_constance.dart';
import '../model/bloc_model/product_bloc.dart';
import '../model/bloc_model/product_event.dart';
import '../model/bloc_model/product_state.dart';
import '../model/product_model.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductBloc>().add(InitialProductList());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FailedState) {
                return Text(state.errorMessage);
              }
              if (state is! SuccessState) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }

              final data = state.data;
              return Padding(
                padding: const EdgeInsets.all(15),
                child: StreamBuilder(
                    stream: data,
                    builder: (context, snapshot) {
                      List product = snapshot.data?.docs ?? [];
                      if (product.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.asset('assets/empty-box.png')),
                              const Text(
                                "Product is empty",
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.separated(
                        itemCount: product.length,
                        //shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ProductModel productList = product[index].data();
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutePaths.productDetails,
                                  arguments: ProductData(product: productList));
                            },
                            child: Container(
                              //height: 50,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                  color: const Color(CommonConstance.background).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/box.png')))),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name: ${productList.productName}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Quantity: ${productList.measurement.toString()}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Price: ${productList.price.toString()}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                                DateFormat("dd-MM-yy h:mm a")
                                                    .format(productList
                                                        .createdOn
                                                        .toDate()),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
              );
            }));
  }
}

