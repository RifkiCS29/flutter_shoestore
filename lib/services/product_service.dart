import 'dart:convert';
import 'package:flutter_shoestore/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shoestore/models/product_model.dart';

class ProductService {

  Future<List<ProductModel>> getProducts() async {
    var url = '${baseUrl}public/api/products';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Get Products Failed');
    }
  }
}
