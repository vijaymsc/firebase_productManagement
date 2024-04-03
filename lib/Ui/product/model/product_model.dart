//product name, measurement, and price, and generate a QR
// code based on the product name.
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

  // ProductModel.fromJson(Map<String, Object?> json)
  //     : this(
  //         productName: json['productName']! as String,
  //         measurement: json['measurement']! as int,
  //         price: json['price']! as int,
  //         qrPath: json['qrPath'] as String,
  //         createdOn: json['createdOn']! as Timestamp,
  //       );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productName: json['productName'],
        measurement: json['measurement'],
        price: json['price'],
        qrPath: json['qrPath'],
        createdOn: json['createdOn']);
  }

  ProductModel copyWith({
    String? productName,
    int? measurement,
    int? price,
    String? qrPath,
    Timestamp? createdOn,
  }) {
    return ProductModel(
        productName: productName ?? this.productName,
        measurement: measurement ?? this.measurement,
        price: price ?? this.price,
        qrPath: qrPath ?? this.qrPath,
        createdOn: createdOn ?? this.createdOn);
  }

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'measurement': measurement,
        'price': price,
        'qrPath': qrPath,
        'createdOn': createdOn
      };
}
