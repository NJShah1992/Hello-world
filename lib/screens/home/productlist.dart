import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_cart/models/user.dart';
import 'package:shop_cart/services/auth.dart';
import 'package:shop_cart/services/database.dart';
import 'package:shop_cart/models/products.dart';

class ProductList extends StatefulWidget {
  final Function toggleView1;
  ProductList({this.toggleView1});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List cart_item = [];
  //int inc;
  final prod_name ='';
  List product_list = [
  {
  "name":"Split AC",
  "Picture":"assets/0.jpeg",
  "Price":25000,
  },
    {
      "name":"Fan",
      "Picture":"assets/1.jpeg",
      "Price":1000,
    },
    {
      //"id":"2",
      "name":"Grinder",
      "Picture":"assets/2.jpeg",
      "Price":5000,
    },
    {
      //"id":"3",
      "name":"Earphone",
      "Picture":"assets/3.jpeg",
      "Price":1000,
    },
    {
      //"id":"4",
      "name":"Watch",
      "Picture":"assets/4.jpeg",
      "Price":2500,
    },
    {
      //"id":"5",
      "name":"Toaster",
      "Picture":"assets/5.jpeg",
      "Price":4000,
    },
    {
      //"id":"6",
      "name":"Roti maker",
      "Picture":"assets/6.jpeg",
      "Price":3000,
    },
    {
      //"id":"7",
      "name":"Sewing machine",
      "Picture":"assets/7.jpeg",
      "Price":10000,
    },
    {
      //"id":"8",
      "name":"Refrigerator",
      "Picture":"assets/8.jpeg",
      "Price":30000,
    },
  ];
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.grey[800],
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.shopping_cart),
            label: Text('Cart'),
            onPressed: (){
              widget.toggleView1();
            },
          )
        ],
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: product_list.length,
          itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20.0))),
                margin: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0.0),
                child: GridTile(
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/$index.jpeg',
                        width: 200.0,height: 120.0,fit: BoxFit.contain,),
                        //SizedBox(height: 2.0),
                        //Text(widget.name[index]),
                        //SizedBox(height: 2.0),
                        FlatButton.icon(
                          icon: Icon(Icons.shopping_cart),
                          label: Text('Add to Cart'),
                          onPressed: () async {
                            await DatabaseService(uid: user.uid).updateUserData(product_list[index]);
                          },
                        )
                      ],
                    )
                ),
              ),
            );
          }
      ),
    );
  }
}
