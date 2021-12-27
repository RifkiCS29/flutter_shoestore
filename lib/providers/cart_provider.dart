import 'package:flutter/material.dart';
import 'package:flutter_shoestore/models/cart_model.dart';
import 'package:flutter_shoestore/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> _toRemove = [];

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(ProductModel product) {
    if (productExist(product)) {
      int index =
          _carts.indexWhere((element) => element.product.id == product.id);
      _carts[index].quantity++;
    } else {
      _carts.add(
        CartModel(
          id: _carts.length,
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  removeCart(int id) {
    if (_carts.length > 0) {
      _carts.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

  addQuantity(int id) {
    _carts.where((element) => element.id == id).forEach((element) {
      element.quantity++;
    });
    notifyListeners();
  }

  reduceQuantity(int id) {
    _carts.where((element) => element.id == id).forEach((element) {
      element.quantity--;
      if (element.quantity == 0) {
        _toRemove.add(element);
      }
    });

    _carts.removeWhere((e) => _toRemove.contains(e));
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in _carts) {
      total += item.quantity;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      total += (item.quantity * item.product.price);
    }
    return total;
  }

  productExist(ProductModel product) {
    if (_carts.indexWhere((element) => element.product.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }
}
