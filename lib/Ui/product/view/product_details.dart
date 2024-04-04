import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Constance/common_constance.dart';
import '../model/product_model.dart';

class ProductDetails extends StatefulWidget {
  ProductData? argument;
  ProductDetails({super.key, this.argument});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(CommonConstance.background),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'Product Details',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/box.png')))),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${widget.argument!.product!.productName}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Quantity: ${widget.argument!.product!.measurement.toString()}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Price: ${widget.argument!.product!.price.toString()}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          'CreatedOn: ${DateFormat("dd-MM-yy h:mm a").format(widget.argument!.product!.createdOn.toDate())}',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis)
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 300,
                width: 300,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder_qr.png',
                  image: widget.argument!.product!.qrPath,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductData {
  ProductModel? product;
  ProductData({this.product});
}
