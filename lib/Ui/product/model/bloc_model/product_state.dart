import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductState {}

class InitialProductSate extends ProductState {}

class SuccessState extends ProductState {
  Stream<QuerySnapshot<Object?>> data;
  SuccessState({required this.data});
}

class AddProductSuccessState extends ProductState {
  final String successMessage;
  AddProductSuccessState({required this.successMessage});
}

class FailedState extends ProductState {
  String errorMessage;
  FailedState({required this.errorMessage});
}

class LoadingState extends ProductState {}
