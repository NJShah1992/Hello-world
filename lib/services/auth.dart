import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_cart/models/user.dart';
import 'package:shop_cart/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
User _userFromFirebaseUser(FirebaseUser user){
  return user != null ? User(uid: user.uid) : null;
}

//auth change user stream
Stream<User> get user {
  return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
}
  //Sign in
Future signInWithEmailAndPassword(String email,String password) async {
  try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}

  //Register
Future registerWithEmailAndPassword(String email,String password) async {
  try{
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    //create a new document for uid in firestore
    await DatabaseService(uid: user.uid).update();
    return _userFromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}

  //Signout
Future signOut() async {
  try{
    return await _auth.signOut();
  }catch(e){
    return null;
  }
}
}