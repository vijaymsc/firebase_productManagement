import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/Ui/product/model/bloc_model/product_event.dart';
import 'package:product_management/Ui/product/model/bloc_model/product_state.dart';

import '../../view_model/database_services.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final DataBaseServices _dataBaseServices = DataBaseServices();
  ProductBloc() : super(InitialProductSate()) {
    on<InitialProductList>(getInitialProductList);
    on<AddProductEvent>(addProduct);
  }
  Future<void> getInitialProductList(
      InitialProductList event, Emitter<ProductState> emit) async {
    if (!await _isConnected()) {
      emit(FailedState(errorMessage: 'No internet connection'));
      return;
    }
    emit(LoadingState());
    try {
      final data = _dataBaseServices.getProduct();
      emit(SuccessState(data: data));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }

  Future<void> addProduct(
      AddProductEvent event, Emitter<ProductState> emit) async {
    if (!await _isConnected()) {
      emit(FailedState(errorMessage: 'No internet connection'));
      return;
    }
    emit(LoadingState());
    try {
      final product = event.product;
      _dataBaseServices.addProduct(product);
      emit(
          AddProductSuccessState(successMessage: "Product Added Successfully"));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }

  Future<bool> _isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
