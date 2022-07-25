import 'package:ecommerce_app_panal/screens/Home_screen.dart';
import 'package:ecommerce_app_panal/screens/new_product_screen.dart';
import 'package:ecommerce_app_panal/screens/order_screen.dart';
import 'package:ecommerce_app_panal/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Ecommerce Backend',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const HomeScreen(),
      getPages: [
        GetPage(name: '/products', page: ()=> ProductScreen()),
       GetPage(name: '/newproducts', page: ()=>   NewProductScreen()),
       GetPage(name: '/orderproducts', page: ()=>    OrdersScreen()),
      ],
    );
  }
}

