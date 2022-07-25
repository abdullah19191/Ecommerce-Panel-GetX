import 'package:ecommerce_app_panal/controllers/Product_controller.dart';
import 'package:flutter/material.dart';

import '../models/Product_models.dart';
import 'package:get/get.dart';

import 'new_product_screen.dart';
class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);
  final ProductController productController = Get.put(ProductController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Products'),backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Card(
                color: Colors.black,
                child: Row(
                  children:[
                    IconButton(onPressed: (){Get.to(()=> NewProductScreen());},icon: Icon(Icons.add_circle,color: Colors.white,)),
                   const Text(
                     'Add New Products',
                     style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                   )
                  ],
                ),
              ),
            ),
            Expanded(
              child:  Obx(
                    () =>ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context,index){
                return SizedBox(
                    height: 210,
                    child: ProductCard(product: productController.products[index],index: index,),
                  );
              })),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget{
  final Product product;
  final int index;
  ProductCard({Key? key,required this.index,required this.product}) : super(key: key);
  final ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(product.name,style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 10,),
          Text(product.description,style: const TextStyle(
            fontSize: 12,
          ),),
          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(product.imageUrl,
                fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children:[
                    Row(
                      children:[
                        Text('Price',style: TextStyle(
                          fontSize:13,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(
                          width: 166,
                          child: Slider(
                            max: 25,min: 0,divisions: 10,activeColor: Colors.black,inactiveColor: Colors.black12,
                            value: product.price, onChanged:(value){
                              productController.updateProductPrice(index, product, value);
                          },
                          onChangeEnd: (value){
                              productController.saveNewProductPrice(product, 'price', value);
                          },
                          ),
                        ),
                        Text('\$${product.price.toStringAsFixed(1)}',style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                    Row(
                      children:[
                        Text('Qty.',style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(
                          width: 170,
                          child: Slider(
                              max: 25,min: 0,divisions: 10,activeColor: Colors.black,inactiveColor: Colors.black12,
                              value: product.quantity.toDouble(), onChanged:(value){
                                productController.updateProductQuantity(index, product, value.toInt());
                          }),
                        ),
                        Text('${product.quantity.toInt()}',style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],),
      ),
    );
  }
}
