import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_cart/models/products.dart';
import 'package:shop_cart/models/user.dart';
import 'package:shop_cart/screens/authenticate/authenticate.dart';
import 'package:shop_cart/screens/home/home.dart';
import 'package:shop_cart/services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return either home or authenticate
    if(user == null){
      return Authenticate();
    } else {
      return StreamProvider<List<Prod>>.value(
        value: DatabaseService().products,
        child: Home(),
      );
    }
  }
}
