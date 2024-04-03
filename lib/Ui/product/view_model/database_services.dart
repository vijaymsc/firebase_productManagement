import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../custom_widget/custom_widget.dart';
import '../model/product_model.dart';

const String product_ref = 'product';

class DataBaseServices {
  final _fireStoreRef = FirebaseFirestore.instance;
  late final CollectionReference _productRef;
  DataBaseServices() {
    _productRef = _fireStoreRef
        .collection(product_ref)
        .withConverter<ProductModel>(
            fromFirestore: (snapShots, _) =>
                ProductModel.fromJson(snapShots.data()!),
            toFirestore: (product, _) => product.toJson());
  }
  Stream<QuerySnapshot> getProduct() {
    return _productRef.snapshots();
  }

  void addProduct(ProductModel product) {
    _productRef.add(product);
  }
}
