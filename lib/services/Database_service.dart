import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Order_model.dart';
import '../models/Product_models.dart';

class DatabaseService{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<List<Order>> getOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map((snap){
    return snap.docs.map((doc) => Order.fromSnapshot(doc)).toList();});
  }

  Stream<List<Product>> getProduct() {
    return _firebaseFirestore.collection('products').snapshots().map((snap){
      return snap.docs.map((doc) => Product.fromSnapshot(doc)).toList();});
  }

  Future<void> addProduct(Product product){
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> updateField(
      Product product,
      String field,
      dynamic newValue
      ){
         return _firebaseFirestore.collection('products').where('id', isEqualTo: product.id).get().then((snap) =>
         snap.docs.first.reference.update({field:newValue})
         );
  }

  Future<void> updateOrder(
      Order order,
      String field,
      dynamic newValue
      ){
    return _firebaseFirestore.collection('orders').where('id', isEqualTo: order.id).get().then((snap) =>
        snap.docs.first.reference.update({field:newValue})
    );
  }

}