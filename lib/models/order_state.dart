import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
class OrderState{
  final DateTime dateTime;
  final int index;
  final int orders;
  charts.Color? barColor;

  OrderState({required this.dateTime,required this.orders,required this.index,
    this.barColor}) {
    barColor = charts.ColorUtil.fromDartColor(Colors.black);
  }

  static final List<OrderState> data = [
    OrderState(dateTime: DateTime.now(),
        orders: 10,
        index: 0),
    OrderState(dateTime: DateTime.now(),
        orders: 12,
        index: 1),
    OrderState(dateTime: DateTime.now(),
        orders: 10,
        index: 27),
    OrderState(dateTime: DateTime.now(),
        orders: 30,
        index: 25),
    OrderState(dateTime: DateTime.now(),
        orders: 14,
        index: 19),
  ];
}