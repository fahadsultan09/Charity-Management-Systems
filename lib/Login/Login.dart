import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notifier/Home/Home.dart';
import 'package:notifier/Login/Authentication.dart';
import 'package:toast/toast.dart';

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
  FirebaseMessaging fcm = FirebaseMessaging();
  String _fcm = "";
  bool obsureTextValue = true;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _saveDeviceToken();
  }

  void _saveDeviceToken() async {
    _fcm = await fcm.getToken();
  }

  void _changeText() {
    setState(() {
      if (obsureTextValue) {
        obsureTextValue = false;
      } else {
        obsureTextValue = true;
      }
    });
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid");
      return true;
    }
    return false;
  }

  Future validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        Center(
          child: CircularProgressIndicator(),
        );
        var user = await auth.signInWithEmailAndPassword(
            email: _email, password: _password);

        if (user != null) {
          Firestore.instance.collection("Users2").document(user.user.uid).updateData({
            "token":_fcm,
          });
          Toast.show("Your Account has Login Successfully", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.green[500]);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      } catch (e) {
        print(e.toString());
        if (e.toString() ==
            "PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)") {
          Toast.show("Login Failed ! Wrong Password", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.red);
        } else if (e.toString() ==
            "PlatformException(ERROR_TOO_MANY_REQUESTS, We have blocked all requests from this device due to unusual activity. Try again later. [ Too many unsuccessful login attempts. Please try again later. ], null)") {
          Toast.show("No More than One Request at a Time ! Try Again", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.red);
        } else if (e.toString() ==
            "PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)") {
          Toast.show("Sorry ! This user is not Found", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.red);
        } else if (e.toString() ==
            "PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)") {
          Toast.show("Email Format is not Correct", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.red);
        } else if (e.toString() ==
            "PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)") {
          Toast.show("Bad or No Internet Connection", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.red);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        body: Form(
          key: _formKey,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Image(
                image: AssetImage('assets/images/images.jpg'),
                fit: BoxFit.cover,
                color: Colors.black45,
                colorBlendMode: BlendMode.darken,
              ),
              ListView(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                          child: Text('Tadbeer',
                              style: TextStyle(
                                color: Colors.white54,
                                  fontSize: 55.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                          child: Text('Contributor',
                              style: TextStyle(
                                color: Colors.white54,
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
                      padding:
                          EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          new TextFormField(
                            style: new TextStyle(color: Colors.white),
                            onChanged: (value) {
                              _email = value;
                            },
                            validator: (input) =>
                                EmailFieldValidator.validate(input),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                          SizedBox(height: 20.0),
                          new TextFormField(
                            style: new TextStyle(color: Colors.white),
                            validator: (input) =>
                                PasswordFieldValidator.validate(input),
                            onChanged: (value) {
                              _password = value;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: new Icon(Icons.remove_red_eye),
                                  onPressed: _changeText,
                                  color: Colors.grey,
                                ),
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                            obscureText: obsureTextValue,
                          ),
                          SizedBox(height: 40.0),
                          GestureDetector(
                            onTap: validateAndSubmit,
                            child: Container(
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
                      )),
                  SizedBox(height: 15.0),
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                ],
              )
            ],
          ),
        ));
  }
}

class EmailFieldValidator {
  static String validate(String input) {
    if (input.isEmpty) {
      return 'Please Type an Email.';
    } else {
      return null;
    }
  }
}

class PasswordFieldValidator {
  static String validate(String input) {
    if (input.length < 6) {
      return 'Password length should be greater than 6.';
    } else {
      return null;
    }
  }
}
