
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notifier/Login/Login.dart';
import 'package:notifier/MyReciever/MyReciever.dart';
import 'package:notifier/Zakat/Zakat.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  String _fullName = "Loading..";
  int amount = 0;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        Firestore.instance.collection("Users2").document(user.uid).get().then((doc){
          _fullName = doc["Full Name"];
          amount = doc["Amount"];
        });
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
        elevation: 1.0,
        child: Container(
          child: Stack(fit:StackFit.expand,children: <Widget>[

            Image.asset("assets/images/images.jpg",fit: BoxFit.cover,color: Colors.black54,colorBlendMode: BlendMode.darken,),
            ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            
            DrawerHeader(
 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.white70,
                      child: Icon(Icons.perm_identity,size: 40,color: backgroundcolor,),
                    ),
                    Text(_fullName.toString(),style: TextStyle(color: Colors.white70,))
                  ],
                ),
            ),
            ListTile(
              
              leading: Icon(Icons.home,color: Colors.white70,),
              title: Text('Home',style: TextStyle(color: Colors.white70,)),
              onTap: () {
                
                
                
                Navigator.pop(context);
              },
            ),
            ListTile(
              
              leading: Icon(Icons.swap_horiz,color: Colors.white70,),
              title: Text('My Funds',style: TextStyle(color: Colors.white70,)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>zakat()));
              },
            ),
            ListTile(
              
              leading: Icon(Icons.account_balance_wallet,color: Colors.white70,),
              title: Text('My Responsibilities',style: TextStyle(color: Colors.white70,)),
              onTap: () {

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>myReciever()));

              },
            ),
            ListTile(
              
              leading: Icon(Icons.attach_money,color: Colors.white70,),
              title: Text('Balance',style: TextStyle(color: Colors.white70,)),
              trailing: Text(amount==0?"":"Rs.   "+amount.toString(),style: TextStyle(color: Colors.white70,)),
            ),
                        
            Divider(color: Colors.black87,height: 50,),
            ListTile(
              subtitle: Text("Exit",style: TextStyle(color: Colors.white70,) ),
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
              },
              
              leading: Icon(Icons.exit_to_app,color: Colors.white70,),
              title: Text("Sign Out",style: TextStyle(color: Colors.white70,fontSize: 15.0)),
              
                          ),
          ],
        ),
        ],)
        ),

      ),
      appBar: AppBar(
         backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("DONOR HOME"),
      ),
      body: Container(
        color: backgroundcolor,
        child: Center(child: Image.asset("assets/images/Logo.jpg"),)
      ),
    );
  }
}

Color backgroundcolor = HexColor("464976");
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}