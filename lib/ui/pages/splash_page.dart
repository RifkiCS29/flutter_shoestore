import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shoestore/providers/product_provider.dart';
import 'package:flutter_shoestore/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String? _token = _preferences.getString("token");
    Navigator.pushNamed(
      context,       
      _token != null ? '/home' : '/sign-in',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/image_splash.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
