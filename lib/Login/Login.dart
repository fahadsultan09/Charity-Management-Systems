
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:notifier/Home/Home.dart';
import 'package:notifier/Login/Authentication.dart';
import 'package:notifier/Login/SignUpPage.dart';

class LoginPage extends StatefulWidget {
    
  LoginPage({
    this.auth,
    this.onSignedIn,
  });
  
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

bool obsureTextValue = true;

  void _ChangeText(){
    setState(() {
     if(obsureTextValue){
       obsureTextValue = false;
     }
     else{
       obsureTextValue = true;
     }
    });
  }


   Future moveToSignUp() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SignupPage(auth: new Auth ())));

  }

  String _email,_password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   FirebaseAuth auth = FirebaseAuth.instance;
  Future validateAndSubmit () async {
      try{
        
        var user =  await auth.signInWithEmailAndPassword(email: _email, password: _password);

        if(user!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
        }
    
      }
      catch (e){
        print(e.toString());
        // Firestore firestore = Firestore 
      }
    
  }







  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: AssetImage('assets/images/images.jpg'),
              fit: BoxFit.cover,
              color: Colors.black45,
              colorBlendMode: BlendMode.darken,
            ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Zakat',
                        style: TextStyle(
                            fontSize: 55.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('Collection',
                        style: TextStyle(
                            fontSize: 45.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(130.0, 175.0, 0.0, 0.0),
                    child: Text('',
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    new TextFormField(
                          onChanged: (value){
                           
                            _email = value;
                             print(_email);
                          },
                          validator: (input){
                              EmailFieldValidator.validate(input);
                          },
                          // onSaved: (input) => _email = input,
                          keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 20.0),
                    new TextFormField(
                          validator: (input){
                            PasswordFieldValidator.validate(input);
                          },
                          onChanged: (value){
                           
                            _password = value;
                             print(_password);
                          },
                          keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                           suffixIcon: IconButton(icon: new Icon(Icons.remove_red_eye),onPressed: _ChangeText ,color: Colors.grey,),
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: obsureTextValue,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    GestureDetector(
                          onTap: validateAndSubmit,
                          child:  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: CupertinoColors.activeGreen,
                        elevation: 7.0,
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                      
                      )),
                          ),
                    SizedBox(height: 20.0),
                                    ],
                )
                ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to Apparel ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: moveToSignUp,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        )




          ],
        ) 
        
    );
  }
}
class EmailFieldValidator{
  static String validate(String input){
    if(input.isEmpty){
      return 'Please Type an Email.';
    } else {
      return null;
    }
  }
}
class PasswordFieldValidator{
  static String validate(String input){
    if (input.length < 6) {
      return 'Password length should be greater than 6.';
    } else {
      return null;
    }
  }
}