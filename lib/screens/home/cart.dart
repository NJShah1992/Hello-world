import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_cart/models/products.dart';
import 'package:shop_cart/services/auth.dart';
import 'package:shop_cart/services/database.dart';
import 'package:shop_cart/models/user.dart';
import 'package:shop_cart/services/loading.dart';


class Cart extends StatefulWidget {
  final Function toggleView1;
  Cart({this.toggleView1});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List cartProduct = [];
  var total;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder(
      stream: Firestore.instance.collection('products').document(user.uid).snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          //print('nodata');
          //print(user.uid);
          return Loading();
        }else{
          cartProduct = snapshot.data['Product'];
          //print(user.uid);
          //print(cartProduct);
          //print('success');
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text('Cart'),
              backgroundColor: Colors.grey[800],
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                  onPressed: (){
                    widget.toggleView1();
                  },
                )
              ],
            ),
            body: ListView.builder(
              itemCount: cartProduct.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        //backgroundImage: AssetImage('assets/${cartProduct[index]}.jpeg'),
                        backgroundImage: AssetImage(cartProduct[index]["Picture"]),
                      ),
                      title: Text(cartProduct[index]["name"]),
                      subtitle: Text('${cartProduct[index]["Price"]}'),
                      onTap: ()async{
                        await DatabaseService(uid: user.uid).deleteUserData(cartProduct[index]);
                        setState(() {
                          total=0;
                          for (var a=0; a<cartProduct.length; a++) {
                            total = total + cartProduct[a]["Price"];
                          }
                        });
                        //print(index);
                      },
                    ),
                  ),
                );
              },
            ),
            bottomSheet: ListTile(
              leading: Title(child: Text('Total:',style: TextStyle(fontSize: 30.0,),),color: Colors.red,),
              subtitle:  Text('$total'),
              trailing: RaisedButton(
                color: Colors.red,
                child: Text('Checkout'),
                onPressed: (){
                  setState(() {
                    total=0;
                    for (var a=0; a<cartProduct.length; a++){
                      total =  total + cartProduct[a]["Price"] ;
                    }
                  });
                },
              ),
            ),
          );
        }
      },
    );
  }
}
