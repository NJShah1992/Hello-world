import 'package:flutter/material.dart';
import 'package:shop_cart/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        title: Text('Sign up to Shop Cart'),
        //actions: <Widget>[
          //FlatButton.icon(onPressed: (){
            //widget.toggleView();
          //}, icon: Icon(Icons.person), label:Text('Sign In'))
        //],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/logo.png',height: 200.0,width: 200.0,),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() => email = val);

                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);

                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink,
                child: Text('Register',style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result  = await _auth.registerWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() => error = 'Please supply a valid email');
                    }
                  }
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink,
                  child: Text('Already have an acount',style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    widget.toggleView();
                  }
              ),
              SizedBox(height: 15.0),
              Text (
                error,
              )
            ],
          ),
        ),
      ),
    );
  }
}
