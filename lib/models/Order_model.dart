import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Order extends Equatable{
  final int id;
  final int customerId;
  final List<dynamic> productIds;
  final double deliveryFee;
  final bool isAccepted;
  final bool isCancelled;
  final bool isDelivered;
  final double subTotal;
  final double total;
  final DateTime createAt;

 const Order({required this.isCancelled,required this.total,required this.deliveryFee,required this.id,
    required this.productIds,required this.isDelivered,required this.createAt,
    required this.subTotal,required this.customerId,required this.isAccepted});

  Order copyWith({
    int? customerId,
    int? id,
    List<dynamic>? productIds,
    double? deliveryFee,
    double? total,
    bool? isAccepted,
    bool? isDelivered,
    bool? isCancelled,
    double? subTotal,
    DateTime? createAt,
  }) {
    return Order(
        customerId: customerId ?? this.customerId,
        isCancelled: isCancelled ?? this.isCancelled,
        id: id ?? this.id, isAccepted: isAccepted??this.isAccepted,
        isDelivered: isDelivered ?? this.isDelivered,
        total: total ?? this.total,
        subTotal: subTotal ?? this.subTotal,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        createAt: createAt?? this.createAt,
        productIds: productIds??this.productIds
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'customerId' : customerId,
      'createAt' : createAt,
      'total' : total,
      'deliveryFee': deliveryFee,
      'isAccepted' : isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'subTotal' : subTotal,
      'productIds': productIds,
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot snap){
    return Order(
      id: snap.data().toString().contains('id')? snap.get('id') : 0,
      customerId: snap.data().toString().contains('customerId') ?snap.get('customerId') : 0,
      subTotal: snap.data().toString().contains('subTotal') ?snap.get('subTotal') : 0,
      total: snap.data().toString().contains('total') ?snap.get('total') : 0,
      createAt: snap['createAt'].toDate(),
      deliveryFee: snap.data().toString().contains('deliveryFee')  ? snap.get('deliveryFee') : 0,
      isAccepted: snap.data().toString().contains('isAccepted') ? snap.get('isAccepted') : false,
      isCancelled: snap.data().toString().contains('isCancelled') ? snap.get('isCancelled') : false,
      isDelivered: snap.data().toString().contains('isDelivered') ? snap.get('isDelivered') : false,
      productIds: snap.data().toString().contains('productIds') ? snap.get('productIds').toList() : [],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;




  @override
  List<Object?> get props => [customerId,
    id,
    productIds,
    deliveryFee,
    total,
    isAccepted,
    isDelivered,
    subTotal,
    isCancelled,
    createAt];

  static List<Order> orders = [
  Order(
  id: 1,
  customerId: 2345,
  productIds: const ['1','2'],
   total: 30,
  isAccepted: true,
  isDelivered: false,
  subTotal: 20,
    isCancelled: false,
  deliveryFee:
  10, createAt: DateTime.now(),
  ),
    Order(
      id: 2,
      customerId: 3345,
      productIds: const ['1','2','3'],
      total: 30,
      isAccepted: true,
      isCancelled:false,
      isDelivered: false,
      subTotal: 20,
      deliveryFee: 10,
      createAt: DateTime.now(),
    ),
  ];
}