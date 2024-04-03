import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../custom_widget/custom_widget.dart';
import '../model/product_model.dart';
import '../view_model/database_services.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _firebaseStorage = FirebaseStorage.instance;

  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productMeasurement = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final DataBaseServices _dataBaseServices = DataBaseServices();
  final ScreenshotController _screenshotController = ScreenshotController();
  String qrData = '';
  bool isQrShow = false;
  String grImgUrl = '';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productName.clear();
    _productMeasurement.clear();
    _productPrice.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text('Add Product'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          formFieldController: _productName,
                          hintTextValue: 'Enter Product Name',
                          validatorFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "Product not empty...";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          inputType: TextInputType.number,
                          formFieldController: _productMeasurement,
                          hintTextValue: 'Enter Quantity',
                          validatorFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "Quantity not empty...";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          formFieldController: _productPrice,
                          inputType: TextInputType.number,
                          hintTextValue: 'Enter Price',
                          validatorFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "Price not empty...";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Visibility(
                          visible: isQrShow ? false : true,
                          child: CustomButton(
                            btnText: 'Generate Qr',
                            btnClick: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isQrShow = !isQrShow;
                                  qrData = _productName.text;
                                });
                                grImgUrl =
                                    (await saveQrImage(_productName.text)) ??
                                        '';
                              }
                            },
                          ),
                        ),
                        Visibility(
                          visible: isQrShow,
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Screenshot(
                              controller: _screenshotController,
                              child: QrImage(
                                data: qrData,
                                version: QrVersions.auto,
                                gapless: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Visibility(
                visible: isQrShow,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    btnText: 'Add Product',
                    btnClick: () async {
                      ProductModel product = ProductModel(
                          productName: _productName.text,
                          measurement:
                              int.tryParse(_productMeasurement.text) ?? 1,
                          price: int.tryParse(_productPrice.text) ?? 100,
                          qrPath: grImgUrl,
                          createdOn: Timestamp.now());
                      _dataBaseServices.addProduct(product);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> saveQrImage(String productName) async {
    final Uint8List? unit8list = await _screenshotController.capture();
    if (unit8list != null) {
      try {
        SettableMetadata metadata = SettableMetadata(
          contentType: 'image/png',
        );

        /// store image in firebase storage
        await _firebaseStorage
            .ref()
            .child('images/$productName.png')
            .putData(unit8list, metadata);

        /// get the uploaded image url
        String downloadURL = await _firebaseStorage
            .ref()
            .child('images/$productName.png')
            .getDownloadURL();
        return downloadURL;
      } catch (e) {
        showLog('Error uploading image: $e');
      }
    }
    return null;
  }
}
