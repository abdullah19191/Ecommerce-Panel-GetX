import 'package:get/get.dart';
import '../models/Order_model.dart';

import '../services/Database_service.dart';

class OrderController extends GetxController{
DatabaseService databaseService =   DatabaseService();

var orders = <Order>[].obs;

@override
  void onInit() {
    orders.bindStream(databaseService.getOrders());
    super.onInit();
  }

  void updateOrder(String field,Order order,bool value){
  databaseService.updateOrder(order, field, value);
  }


}