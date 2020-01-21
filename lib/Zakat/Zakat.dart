
import 'dart:math';

import 'package:flutter/material.dart';



class zakat extends StatefulWidget {
  @override
  _zakatState createState() => _zakatState();
}

class _zakatState extends State<zakat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text("Zakat"),),
          body: Container(
            child: ListView.builder(
       // physics: NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: _zakat.length,
        itemBuilder: (BuildContext context, int index) {
            Map transaction = _zakat[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/islamabad.jpg"),
                  radius: 25,
                ),
                // title: Text(transaction['name']),
                title: Text(transaction["name"]),
                subtitle: Text(transaction['date']),
                trailing: Text(
                  transaction['type'] == "sent"
                      ?"-${transaction['amount']}"
                      :"+${transaction['amount']}",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
        },

      ),
          ),
    );
  }
}
List _zakat = List.generate(50, (index)=>{
  "name": "Fahad Sultan",
  "date": "${random.nextInt(31).toString().padLeft(2,"0")}"
      "/${random.nextInt(12).toString().padLeft(2,"0")}/2019",
  "amount": "\Rs.${random.nextInt(1000).toString()}",
  // "image": "assets/images/islamabad.jpg",
});

Random random = Random();

