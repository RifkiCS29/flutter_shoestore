import 'dart:convert';
import 'package:flutter_shoestore/utils/constant.dart';
import 'package:http/http.dart' as http;
import '../models/cart_model.dart';

class TransactionService {

  Future<bool> checkout(
      String token, List<CartModel> carts, String address, double totalPrice) async {
    var url = '${baseUrl}public/api/checkout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        'address': address,
        'items': carts
            .map(
              (cart) => {
                'id': cart.product.id,
                'quantity': cart.quantity,
              },
            )
            .toList(),
        'status': "PENDING",
        'total_price': totalPrice,
        'shipping_price': 0,
      },
    );

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Melakukan Checkout!');
    }
  }
}
