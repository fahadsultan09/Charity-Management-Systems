
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class myReciever extends StatefulWidget {
  @override
  _myRecieverState createState() => _myRecieverState();
}

class _myRecieverState extends State<myReciever> {
  String uid;
  @override
  void initState() { 
    super.initState();
    FirebaseAuth.instance.currentUser().then((value){
      setState(() {
        uid = value.uid;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,title: Text("MY RECIEVERS"),
            ),

              body: Container(
         decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, Colors.blue[900]])
              
              ),
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: Firestore.instance.collection("MyZakat").document(uid).collection("MyPayments").orderBy('timestamp',descending: true).getDocuments(),
          
          builder: buildReciever,
        ),
      ),
      
    );
    
  }

  Widget buildReciever(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

    if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data.documents[index];

                return GestureDetector(
                    onTap: (){
                      
                    },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white70, Colors.blue[900]]),
              
              
                  borderRadius: BorderRadius.circular(12.0),
                ),
                
                
                child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ListTile(
                
                
                
                
                
                title: Text("Reciever Name :"+user["Name"],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                subtitle: Text("Payment Date: "+user["PaymentDate"],style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                trailing: Text(
                "Rs. "+user["Amount"].toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
              ),
                );
            },
        );
    } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData ){
        
        return Center(
            child: Text("No Pipeline found.",style: TextStyle(color: Colors.black),),
        );
    } else {
        
        return Center(child: CircularProgressIndicator());
    }
}
  
}