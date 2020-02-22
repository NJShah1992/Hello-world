import 'package:flutter/material.dart';
import 'package:shop_cart/screens/home/cart.dart';
import 'package:shop_cart/screens/home/productlist.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showProduct = true;

  void toggleView1() {
    setState(() => showProduct = !showProduct);
  }

  @override
  Widget build(BuildContext context) {
    if (showProduct) {
      return ProductList(toggleView1: toggleView1);
    } else {
      return Cart(toggleView1: toggleView1);
    }
  }
}