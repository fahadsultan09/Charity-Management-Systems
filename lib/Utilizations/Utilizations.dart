import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notifier/Utils/Utils.dart';

class Utilizations extends StatefulWidget {
  @override
  _UtilizationsState createState() => _UtilizationsState();
}

class _UtilizationsState extends State<Utilizations> {
  String uid;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
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
        backgroundColor: Colors.black,
        title: Text("Utilizations"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.black, backgroundcolor])),
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: Firestore.instance
              .collection("MyZakat")
              .document(uid)
              .collection("MyPayments")
              .orderBy('timestamp', descending: true)
              .getDocuments(),
          builder: buildReciever,
        ),
      ),
    );
  }

  Widget buildReciever(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot user = snapshot.data.documents[index];

          return Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white70, backgroundcolor]),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: GestureDetector(
              onTap: () {},
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListTile(
                    title: Text("Name :" + user["Name"],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      "Payment Date: " + user["PaymentDate"],
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Rs. " + user["Amount"].toString(),
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Purpose: " + user["Purpose"].toString(),
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
      );
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      return Center(
        child: Text(
          "No Utilizations found.",
          style: TextStyle(color: Colors.white70),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
