import 'package:flutter/material.dart';

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
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.argument!.product!.productName),
            SizedBox(
                height: 300,
                width: 300,
                child: Image.network(widget.argument!.product!.qrPath)),
          ],
        ),
      ),
    );
  }
}

class ProductData {
  ProductModel? product;
  ProductData({this.product});
}
