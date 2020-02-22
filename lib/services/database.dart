import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_cart/models/products.dart';
import 'package:shop_cart/models/user.dart';
import 'package:shop_cart/services/auth.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference productCollection = Firestore.instance.collection('products');
final AuthService _auth = AuthService();
  Future update()async{
    return await productCollection.document(uid).setData({
      "Product" : [],
    });
  }

  Future updateUserData(product) async {
    return await productCollection.document(uid).setData({
        "Product": FieldValue.arrayUnion([product]),
    },merge: true);
  }

  Future deleteUserData(product) async {
    return await productCollection.document(uid).setData({
      "Product": FieldValue.arrayRemove([product]),
    },merge: true);
  }


 /* List<Prod> _productListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Prod(
        cartProd: doc.data['Product'],
        //name: doc.data['name'] ?? '',
        //picture: doc.data['picture'] ?? '',
        //price: doc.data['price'] ?? '',
      );
    }).toList();
  }


  //get streams
Stream<List<Prod>> get products{
    //return Firestore.instance.collection('products').document(user.uid).snapshots()
  return productCollection.snapshots()
        .map(_productListFromSnapshot);
}*/
}
