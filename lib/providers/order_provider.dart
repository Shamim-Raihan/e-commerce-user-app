
import 'package:ecom_user_batch5/auth/auth_service.dart';
import 'package:ecom_user_batch5/models/order_model.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/order_constants_model.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();

  Future<void> addOrder(OrderModel orderModel, List<CartModel> cartList) =>
    DbHelper.addNewOrder(orderModel, cartList);

  Future<void> updateProductStock(List<CartModel> cartList) =>
    DbHelper.updateProductStock(cartList);

  Future<void> updateCategoryProductCount(
      List<CartModel> cartList,
      List<CategoryModel> categoryList) =>
    DbHelper.updateCategoryProductCount(cartList, categoryList);

  Future<void> clearUserCartItems(List<CartModel> cartList) =>
    DbHelper.clearUserCartItems(AuthService.user!.uid, cartList);

  Future<void> getOrderConstants() async {
    final snapshot = await DbHelper.getOrderConstants();
    orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
    notifyListeners();
  }

  num getDiscountAmount(num subtotal) {
    return (subtotal * orderConstantsModel.discount) / 100;
  }

  num getVatAmount(num subtotal) {
    final priceAfterDiscount = subtotal - getDiscountAmount(subtotal);
    return (priceAfterDiscount * orderConstantsModel.vat) / 100;
  }

  num getGrandTotal(num subtotal) {
    return (subtotal - getDiscountAmount(subtotal))
        + getVatAmount(subtotal) + orderConstantsModel.deliveryCharge;
  }

}