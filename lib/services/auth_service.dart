import 'dart:convert';

import 'package:flutter_shoestore/models/user_model.dart';
import 'package:flutter_shoestore/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthService {

  Future<UserModel> register({
    required String name,
    required String username,
    required String address,
    required String email,
    required String password,
  }) async {
    var url = '${baseUrl}public/api/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'address': address,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Register Failed');
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = '${baseUrl}public/api/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
     Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Login Failed');
    }
  }

  Future<String> logout(String token) async { 
    var url = '${baseUrl}public/api/logout';
      
    var response = await http.post(
      Uri.parse(url),
      headers:  {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      }
    );

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var value = data['meta']['status'];

      return value;
    } else {
      throw Exception('Logout Failed');
    }
  }
}
