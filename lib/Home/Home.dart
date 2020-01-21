
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hijri/umm_alqura_calendar.dart';
import 'package:notifier/Login/Login.dart';
import 'package:notifier/Zakat/Zakat.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ummAlquraCalendar _islamicDate = new ummAlquraCalendar.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
        elevation: 1.0,
        child: Container(
          child: Stack(fit:StackFit.expand,children: <Widget>[

            Image.asset("assets/images/islamabad.jpg",fit: BoxFit.cover,color: Colors.black54,colorBlendMode: BlendMode.darken,),
            ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            
            DrawerHeader(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Islamic Date',style: TextStyle(color: Colors.white70,fontSize: 20.0)),
              Text(_islamicDate.toString(),style: TextStyle(color: Colors.white70,fontSize: 30.0)),
                ],
              ),
              decoration: BoxDecoration(
                // color: Colors.blue,
              ),
            ),
            ListTile(
              // trailing: Text(),
              leading: Icon(Icons.home,color: Colors.white70,),
              title: Text('Home',style: TextStyle(color: Colors.white70,)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              // trailing: Text(),
              leading: Icon(Icons.account_balance_wallet,color: Colors.white70,),
              title: Text('Zakat',style: TextStyle(color: Colors.white70,)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>zakat()));
              },
            ),
            ListTile(
              // trailing: Text(),
              leading: Icon(Icons.notification_important,color: Colors.white70,),
              title: Text('Notifications',style: TextStyle(color: Colors.white70,)),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              // trailing: Text(),
              leading: Icon(Icons.sentiment_satisfied,color: Colors.white70,),
              title: Text('Feedback',style: TextStyle(color: Colors.white70,)),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            Divider(color: Colors.black87,height: 50,),
            ListTile(
subtitle: Text("Exit"),
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
              },
              // trailing: Text(),
              leading: Icon(Icons.exit_to_app,color: Colors.white70,),
              title: Text("Sign Out",style: TextStyle(color: Colors.white70,fontSize: 20.0)),
              // subtitle: Text(_islamicDate.toString(),style: TextStyle(color: Colors.white70,)),

              // isThreeLine: true,
            ),
          ],
        ),
        ],)
        ),

      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifier"),
      ),
      body: Container(
        child: Center(
          child: Text("FAHAD"),
        ),
      ),
    );
  }
}