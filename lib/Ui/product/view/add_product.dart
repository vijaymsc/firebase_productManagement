import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../Constance/common_constance.dart';
import '../../../custom_widget/custom_widget.dart';
import '../model/bloc_model/product_bloc.dart';
import '../model/bloc_model/product_event.dart';
import '../model/bloc_model/product_state.dart';
import '../model/product_model.dart';

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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(CommonConstance.background),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'Add Product',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
            if (state is FailedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if (state is AddProductSuccessState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.successMessage)));
              context.read<ProductBloc>().add(InitialProductList());
              Navigator.pop(context);
            }
          }, builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/box.png')),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
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
                              return null;
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
                              return null;
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
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
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
                                  grImgUrl = (await saveQrImage(_productName.text)) ?? '';
                                }
                              },
                            ),
                          ),
                          Visibility(
                            visible: isQrShow,
                            child: SizedBox(
                              height: 150,
                              width: 150,
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
                  const SizedBox(
                    height: 20,
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
                          context
                              .read<ProductBloc>()
                              .add(AddProductEvent(product: product));
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  clearData() {
    _productName.clear();
    _productMeasurement.clear();
    _productPrice.clear();
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
        print('downloadURL::$downloadURL');
        return downloadURL;
      } catch (e) {
        showLog('Error uploading image: $e');
      }
    }
    return null;
  }
}
