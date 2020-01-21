// import 'package:flutter/material.dart';
// import 'package:hello_world_app/HomePage.dart';
// import 'package:hello_world_app/Login/Authentication.dart';

 

//  class MappingPage extends StatefulWidget {
   
//    final AuthImplemention auth;

//    MappingPage({
//      this.auth,
//    });

//    @override
//    _MappingPageState createState() => _MappingPageState();
//  }
 
// enum AuthStatus
// {
//   notSignedIn,
//   signedIn,
// }

//  class _MappingPageState extends State<MappingPage> {

//    AuthStatus _authStatus = AuthStatus.notSignedIn;

//   @override
//   void initState() {
//     super.initState();

//     widget.auth.getCurrentUser().then((firebaseUserId)
//     {

//         setState(() {
//           _authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.notSignedIn;
//         });
//     });
//   }

//   void _signedIn()
//   {
//     setState(() {
//      _authStatus = AuthStatus.signedIn; 
//     });
//   }

//   void _signedOut()
//   {
//     setState(() {
//      _authStatus = AuthStatus.notSignedIn; 
//     });
//   }


//    @override
//    Widget build(BuildContext context) {
    

//      switch(_authStatus)
//      {
//        case AuthStatus.notSignedIn:
//        return LoginRegisterPage(
//          auth: widget.auth,
//          onSignedIn: _signedIn
//        );

//       case AuthStatus.signedIn:
//        return mainApplication(
//          auth: widget.auth,
//          onSignedOut: _signedOut,
//        );


//      }
//    return null;
//    }
//  }