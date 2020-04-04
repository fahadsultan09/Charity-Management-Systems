
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notifier/Utils/Utils.dart';



class Zakat extends StatefulWidget {
  @override
  _ZakatState createState() => _ZakatState();
}

class _ZakatState extends State<Zakat> {
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
            centerTitle: true,
            backgroundColor: Colors.black,title: Text("Donations"),
            ),

              body: Container(
         decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, backgroundcolor])
              
              ),
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: Firestore.instance.collection("DPayment").document(uid).collection('MyPayment').getDocuments(),
          
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
 
                title: Text("Mode :"+user["PaymentMode"],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                subtitle: Text("Payment Date: "+user["DateOfPayment"],style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                trailing: Text(
                "Rs. "+user["Amount"],
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
            child: Text("No Donors found.",style: TextStyle(color: Colors.white70),),
        );
    } else {
        
        return Center(child: CircularProgressIndicator());
    }
}
  
}
