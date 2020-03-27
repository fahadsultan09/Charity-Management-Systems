

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notifier/Home/Home.dart';
import 'package:notifier/Models/UserClass.dart';
import 'package:toast/toast.dart';

class SignUpPage2 extends StatefulWidget {
  SignUpPage2(this.user);
  User user;
  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  List<String> responsibilityType = ["Stationary Type", "Business Support"];
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
        
        
       AuthResult _user =  (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.user.email,password:widget.user.password));
      if(_user!=null){

        print("SUCCESS");
          widget.user.uid = _user.user.uid;
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
        "Source Of Income":widget.user.SOC,
        "Education":widget.user.education,
        "Gender":widget.user.gender,
        "Skills":widget.user.skills,
        "Account Number":widget.user.accountNumber,
        

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
        "Source Of Income":widget.user.SOC,
        "Education":widget.user.education,
        "Gender":widget.user.gender,
        "Skills":widget.user.skills,
        "Account Number":widget.user.accountNumber,
        
      });
      


          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
       } 
    
   

          }
          catch (e){
    
           if (e.toString() ==
                    "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)") {
                  Toast.show("Sign Up Failed ! Email already in use", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }

        }
          

          
          
          
          
          
        }
    
      }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
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
   SizedBox(height: 20.0),

              
              
              
              

              
              
              
              

              
                    
              
              
              
              
              
              

              
              
              
              
              
              
              
              
              
              
              
              
                        
              
              
              
              
              
              
           
                

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