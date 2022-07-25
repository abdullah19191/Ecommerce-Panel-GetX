import 'package:ecommerce_app_panal/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/order_state.dart';
import 'order_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(title: Text('My Ecommerce'),backgroundColor: Colors.black,),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
                height: 200,
                child: CustomBarConcert(orderState: OrderState.data)),
            Container(width: double.infinity,height: 150,padding: EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: (){
                Get.to(()=>  ProductScreen());
              },
              child: const Card( 
                child: Center(child: Text('Go To Products')),
              ),
            ),
            ),
            Container(width: double.infinity,height: 150,padding: EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: (){
                  Get.to(()=>  OrdersScreen());
                },
                child: const Card(
                  child: Center(child: Text('Go To OrderScreen')),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}

class CustomBarConcert extends StatelessWidget {
  const CustomBarConcert({Key? key,required this.orderState}) : super(key: key);
  final List<OrderState> orderState;
  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderState,String>> series = [
       charts.Series(
         id: 'order',
         data: orderState,
         domainFn: (series, _) => series.index.toString(),
         measureFn: (series, _) => series.orders,
         colorFn:  (series, _) => series.barColor!,
       )
    ];
    return charts.BarChart(series,animate: true);
  }
}

