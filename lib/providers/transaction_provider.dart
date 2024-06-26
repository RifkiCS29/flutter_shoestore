import 'package:flutter/material.dart';
import 'package:flutter_shoestore/models/cart_model.dart';
import 'package:flutter_shoestore/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> checkout(
      String token, List<CartModel> carts, String address, double totalPrice) async {
    try {
      if (await TransactionService().checkout(token, carts, address, totalPrice)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
