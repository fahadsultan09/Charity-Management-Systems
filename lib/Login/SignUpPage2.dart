

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notifier/Home/Home.dart';
import 'package:notifier/Models/UserClass.dart';

class SignUpPage2 extends StatefulWidget {
  SignUpPage2(this.user);
  User user;
  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
    FirebaseMessaging fcm = FirebaseMessaging();
  String _fcm="";
    int amount = 0;
  
   void _saveDeviceToken() async{
    _fcm = await fcm.getToken();

  }
 
  @override
  void initState() { 
    _saveDeviceToken();
    super.initState();
    
  }

  Firestore _firestore = Firestore.instance;
  final _formKey = new GlobalKey<FormState>();
  List<String> _items = ["Male","Female"];

bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  
  Future validateAndSubmit () async {
    

    if (validateAndSave()){
      try {
        
        
      AuthResult firebaseUser= await FirebaseAuth.instance.signInWithEmailAndPassword(email: widget.user.email, password: widget.user.password);
      // FirebaseUser firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: widget.user.email, password: widget.user.password)).user;    
      if(firebaseUser!=null){

        print("SUCCESS");
          widget.user.uid = firebaseUser.user.uid;
        _firestore.collection("Users").document(widget.user.fatherName).setData({"1":1});
        _firestore.collection("Users").document(widget.user.fatherName).collection("children").document(widget.user.uid).setData(
        {
        "Email": widget.user.email,
        "Full Name": widget.user.fullName,
        "Phone": widget.user.phoneNum,
        "Father Name":widget.user.fatherName,
        "Family Status":widget.user.fatherStatus,
        "Family Group":widget.user.familyGroup,
        "Village Group":widget.user.villageGroup,
        "Amount":amount,
        "token":_fcm,
        "Reference":widget.user.reference,
        "Status Of Reference":widget.user.statusOfReference,
        // "Date Of Birth":widget.user.dob,
        "Source Of Income":widget.user.SOC,
        "Education":widget.user.education,
        "Gender":widget.user.gender,
        "Skills":widget.user.skills,
        "Account Number":widget.user.accountNumber,
        "Member Needed":widget.user.memberNeeded,

      });
        
        
        
        _firestore.collection("Users2").document(widget.user.uid).setData(
        {
        "Email": widget.user.email,
        "Full Name": widget.user.fullName,
        "Phone": widget.user.phoneNum,
        "Father Name":widget.user.fatherName,
        "Family Status":widget.user.fatherStatus,
        "Family Group":widget.user.familyGroup,
        "Village Group":widget.user.villageGroup,
        "token":_fcm,
        "Amount":amount,
        "Reference":widget.user.reference,
        "Status Of Reference":widget.user.statusOfReference,
        // "Date Of Birth":widget.user.dob,   
        "Source Of Income":widget.user.SOC,
        "Education":widget.user.education,
        "Gender":widget.user.gender,
        "Skills":widget.user.skills,
        "Account Number":widget.user.accountNumber,
        "Member Needed":widget.user.memberNeeded,
      });
      


          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
       } 
    
   

          }
          catch (e){
    
           Scaffold.of(context).showSnackBar(SnackBar(content: Text("USER NOT CREATED")));

        }
        }
    
      }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        body:  new Form(
          key: _formKey,
          child: ListView(
          children: <Widget>[

          Container(
              padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  

 SizedBox(height: 10.0),
                 TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Reference cannot be empty' : null,
                      onChanged: (value){
                           
                            widget.user.reference = value;
                          
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'REFERENCE',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 SizedBox(height: 10.0),
                 TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Status Of Reference cannot be empty' : null,
                      onChanged: (value){
                           
                            widget.user.statusOfReference = value;
                 
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'STATUS OF REFERENCE',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 SizedBox(height: 10.0),
                  
//                   TextFormField(
                    
//                     onTap: (){

                        
//                          Future<DateTime> selectedDate = showDatePicker(
//    context: context,
//    initialDate: DateTime(1990),
//    firstDate: DateTime(1950),
//    lastDate: DateTime.now(),
//    builder: (BuildContext context, Widget child) {
//      return Theme(
//        data: ThemeData.dark(),
//        child: child,
//      );
//    },
//  );

//  if(selectedDate!=null){
//     selectedDate.then((onValue){
//       setState(() {
//       widget.user.dob =   onValue.toString().substring(0,10);
//       print(widget.user.dob);

//       });
//     });
//  }
      
//                     },
//                     keyboardType: TextInputType.text,
//                       // validator: (input) => input.isEmpty ? 'DATE OF BIRTH cannot be empty' : null,
                    
//                     onChanged: (value){
//                         setState(() {
                          
//                           value = widget.user.dob;

//                         });
//                     },
//                     decoration: InputDecoration(
//                         suffixIcon: IconButton(icon: Icon(Icons.calendar_today),onPressed: (){
                             
//                         },),
//                         labelText: 'DATE OF BIRTH',
//                         labelStyle: TextStyle(
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey),
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.green))),
//                   ),

//                  SizedBox(height: 10.0),


                 
                   Container(
                width: 150.0,
                height: 60.0,
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.blueGrey),
                ),
                child : DropdownButtonHideUnderline(

                  child: ButtonTheme(
                    
                    alignedDropdown: true,
                    child: new DropdownButton<String>(
                      value: widget.user.gender,
                      items: _items.map((lable) {
                        return new DropdownMenuItem<String>(
                          value: lable,

                          child: new Text(lable),
                        );
                      }).toList(),
                      hint: Text('Gender'),
                      onChanged: (value) {
                        setState((){
                          widget.user.gender = value;
    
                        });
                        
                      },
                    ),
                  ),
              ),
              ),
              SizedBox(height: 10.0),
              
                     TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Source of Income cannot be empty' : null,
                      onChanged: (value){
                           
                            widget.user.SOC = value;
                             
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'SOURCE OF INCOME',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),

 SizedBox(height: 10.0),
                  
                     TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Skills cannot be empty' : null,
                      onChanged: (value){
                           
                            widget.user.skills = value;
                             
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'SKILLS',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),

 SizedBox(height: 10.0),
                  
                     TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Education cannot be empty' : null,
                      onChanged: (value){
                           
                            widget.user.education = value;
                            
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'EDUCATION',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),


                SizedBox(height: 10.0),
              TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'ACCOUNT NUMBER cannot be empty' : null,
                      onChanged: (value){
                           
                            widget.user.accountNumber = value;
                             
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'ACCOUNT NUMBER',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 SizedBox(height: 10.0),        

      TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'MEMBER  cannot be empty' : null,
                      onChanged: (value){
                           
                            widget.user.memberNeeded = value;
                             
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'MEMBER NEEDED',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 SizedBox(height: 10.0),
           
                

                  SizedBox(height: 50.0),

              GestureDetector(
                  onTap: validateAndSubmit,
                  child:  Container(
                      height: 60.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                     
                          child: Center(
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                      
                      )),
                          )
                 
                  
                ],
              )
              ),
        ]
        ) 
          ,)
        
        );

  }
}