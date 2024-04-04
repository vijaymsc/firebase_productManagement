import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productName;
  int measurement;
  int price;
  String qrPath;
  Timestamp createdOn;

  ProductModel(
      {required this.productName,
      required this.measurement,
      required this.price,
      required this.qrPath,
      required this.createdOn});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productName: json['productName'],
        measurement: json['measurement'],
        price: json['price'],
        qrPath: json['qrPath'],
        createdOn: json['createdOn']);
  }

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'measurement': measurement,
        'price': price,
        'qrPath': qrPath,
        'createdOn': createdOn
      };
}
