import 'package:ecom_user_batch5/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrderPage extends StatefulWidget {
  static const String routeName = '/my_order_page';
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).g
    return Scaffold(
      appBar: AppBar(title: Text('My Orders'),),
      body: ,
    );
  }
}
