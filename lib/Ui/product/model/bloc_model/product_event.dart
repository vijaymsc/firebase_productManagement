import '../product_model.dart';

abstract class ProductEvent {}

class InitialProductList extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final ProductModel product;
  AddProductEvent({required this.product});
}
