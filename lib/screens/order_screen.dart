import 'package:ecommerce_app_panal/controllers/Order_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Order_model.dart';
import '../models/Product_models.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);
  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Orders'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
          ()=> ListView.builder(
                itemCount: orderController.orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return   OrderCard(order: orderController.orders[index],);},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
   OrderCard({Key? key,required this.order}) : super(key: key);
   final OrderController orderController = Get.find();
  @override
  Widget build(BuildContext context) {
    var products = Product.products.where((product) => order.productIds.contains(product.id)).toList();
    return Padding(
      padding: const EdgeInsets.only(left: 11.0,right: 11.0,top:11),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Id: ${order.id}", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700),),
                  Text(DateFormat('dd-MM-yy').format(order.createAt), style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400),),
                ],
              ),
             const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Delivery Fee",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700),),
                     SizedBox(height: 10,),
                      Text("${order.deliveryFee}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700),)
                    ],
                  ),
                  Column(
                    children: [
                      Text("Total", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700),),
                      SizedBox(height: 10,),
                      Text("${order.total}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700),)
                    ],
                  )
                ],
              ),
              SizedBox(height: 12,),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                       SizedBox(
                         height: 50,
                         width: 50,
                         child: Image.network(products[index].imageUrl,fit: BoxFit.cover,),
                       ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(products[index].name,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w700,color: Colors.black),),
                            SizedBox(width: 10,),
                            SizedBox(
                              width:200,
                              child: Text(products[index].description,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,color: Colors.black),
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  order.isAccepted?
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: const Size(150, 40),
                      ),
                      onPressed: (){
                        orderController.updateOrder('isDelivered', order, !order.isDelivered);
                      },
                      child:Text("Deliver", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700,color: Colors.white),) ):
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: const Size(150, 40),
                    ),
                      onPressed: (){
                      orderController.updateOrder('isAccepted', order, !order.isAccepted);
                      },
                      child:Text("Accept", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700,color: Colors.white),) ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: const Size(150, 40),
                      ),
                      onPressed: (){
                        orderController.updateOrder('isCancelled', order, !order.isCancelled);
                      },
                      child:Text("Cancel", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700,color: Colors.white),) )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
