import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Product extends Equatable{
  String name;
  String id;
  String category;
  double price;
  String imageUrl;
  bool isRecommended;
  bool isPopular;
  String description;
  int quantity;
  Product({this.quantity = 0,required this.description,required this.id,
    required this.category,required this.isRecommended,required this.isPopular,
    this.price = 0,required this.imageUrl,required this.name});

 Product copyWith({
   String? name,
   String? id,
   String? category,
   double? price,
   String? imageUrl,
   bool? isRecommended,
   bool? isPopular,
   String? description,
   int? quantity,
}) {
   return Product(
       description: description ?? this.description,
       id: id ?? this.id, category: category??this.category,
       isRecommended: isRecommended ?? this.isRecommended,
       isPopular: isPopular ?? this.isPopular,
       imageUrl: imageUrl ?? this.imageUrl,
       name: name ?? this.name,
       price: price?? this.price,
       quantity: quantity??this.quantity
   );
 }
 Map<String,dynamic> toMap(){
   return {
     'id' : id,
     'name' : name,
     'category' : category,
     'description' : description,
     'imageUrl': imageUrl,
     'isPopular' : isPopular,
     'isRecommended': isRecommended,
     'price' : price,
     'quantity': quantity,
   };
 }

 factory Product.fromSnapshot(DocumentSnapshot snap){
   return Product(
     id: snap.data().toString().contains('id')? snap.get('id') : '',
     name: snap.data().toString().contains('name') ?snap.get('name') : '',
     category: snap.data().toString().contains('category') ?snap.get('category') : '',
     imageUrl: snap.data().toString().contains('imageUrl') ?snap.get('imageUrl') : '',
     price: snap.data().toString().contains('price')  ? snap.get('price') : 0,
     quantity: snap.data().toString().contains('quantity')  ? snap.get('quantity') : 0,
     isRecommended: snap.data().toString().contains('isRecommended') ? snap.get('isRecommended') : false,
     isPopular: snap.data().toString().contains('isPopular') ? snap.get('isPopular') : false,
     description: snap.data().toString().contains('description') ?snap.get('description') : '',
   );
 }


  @override
  List<Object?> get props => [name,imageUrl,isPopular,isPopular,price,category,id,description,quantity];

 String toJson() => json.encode(toMap());


@override
bool get stringify => true;

  static List<Product> products = [
    Product(
      id: '1',
      name: 'Soft Drink #1',
      category: 'Soft Drinks',
      imageUrl:
      'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 2.99,
      isRecommended: true,
      isPopular: false,
      description: 'looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooool',
      quantity: 10,
    ),
    Product(
      id: '2',
      name: 'Soft Drink #2',
      category: 'Soft Drinks',
      quantity: 10,
      imageUrl:
      'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80', //https://unsplash.com/photos/Viy_8zHEznk
      price: 2.99,
      isRecommended: false,
      isPopular: true, description: 'looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooool',
    ),
    Product(
      id: '3',
      quantity: 10,
      name: 'Soft Drink #3',
      category: 'Soft Drinks',
      imageUrl:
      'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/5LIInaqRp5s
      price: 2.99,
      isRecommended: true,
      isPopular: true, description: 'looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooool',
    ),
    Product(
      id: '4',
      name: 'Smoothies #1',
      category: 'Smoothies',
      quantity: 10,
      imageUrl:
      'https://images.unsplash.com/photo-1526424382096-74a93e105682?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80', //https://unsplash.com/photos/kcYXj4tBtes
      price: 2.99,
      isRecommended: true,
      isPopular: false, description: 'looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooool',
    ),
    Product(
      id: '5',
      quantity: 10,
      name: 'Smoothies #2',
      category: 'Smoothies',
      imageUrl:
      'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80', //https://unsplash.com/photos/CrK843Pl9a4
      price: 2.99,
      isRecommended: false,
      isPopular: false, description: 'looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooool',
    ),
    Product(
      id: '6',
      name: 'Soft Drink #1',
      category: 'Soft Drinks',
      imageUrl:
      'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 2.99,
      isRecommended: true,
      quantity: 10,
      isPopular: false, description: 'looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooool',
    ),
    Product(
      id: '7',
      quantity: 10,
      name: 'Soft Drink #2',
      category: 'Soft Drinks',
      imageUrl:
      'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80', //https://unsplash.com/photos/Viy_8zHEznk
      price: 2.99,
      isRecommended: false,
      isPopular: true, description: 'looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooool',
    ),
  ];
}
