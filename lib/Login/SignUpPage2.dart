

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notifier/Home/Home.dart';

class SignUpPage2 extends StatefulWidget {

  SignUpPage2(this.userId,this.fatherName);
  String userId,fatherName;
  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {

  String _education="";
  String _skills="";
  String _gender = "Male";
  String _reference ="";
  String _statusOfReference ="";
  String _dob;
  String _accountNumber ="";
  String _memberNeeded ="";
  String _SOC="";
  
  final _formKey = new GlobalKey<FormState>();
  List<String> _items = ["Male","Female"];

  
  Future validateAndSubmit () async {
    
    if (true){
      try {
      if(widget.userId!=null){
          Firestore _firestore = Firestore.instance;
        _firestore.collection("Users").document(widget.fatherName).setData({
          "1":"1",
        });
        _firestore.collection("Users").document(widget.fatherName).collection("children").document(widget.userId).updateData(
        {

        "Reference":_reference,
        "Status Of Reference":_statusOfReference,
        "Date Of Birth":_dob,   
        "Source Of Income":_SOC,
        "Education":_education,
        "Gender":_gender,
        "Skills":_skills,
        "Account Number":_accountNumber,
        "Member Needed":_memberNeeded,

      });
        
        
        
        _firestore.collection("Users2").document(widget.userId).updateData(
        {
        "Reference":_reference,
        "Status Of Reference":_statusOfReference,
        "Date Of Birth":_dob,   
        "Source Of Income":_SOC,
        "Education":_education,
        "Gender":_gender,
        "Skills":_skills,
        "Account Number":_accountNumber,
        "Member Needed":_memberNeeded,
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
        resizeToAvoidBottomPadding: false,
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
                           
                            _reference = value;
                          
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
                           
                            _statusOfReference = value;
                 
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
                  
                  TextFormField(
                    
                    onTap: (){

                        
                         Future<DateTime> selectedDate = showDatePicker(
   context: context,
   initialDate: DateTime(1990),
   firstDate: DateTime(1950),
   lastDate: DateTime.now(),
   builder: (BuildContext context, Widget child) {
     return Theme(
       data: ThemeData.dark(),
       child: child,
     );
   },
 );

 if(selectedDate!=null){
    selectedDate.then((onValue){
      setState(() {
      _dob =   onValue.toString().substring(0,10);

      });
    });
 }
      
                    },
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'DATE OF BIRTH cannot be empty' : null,
                    
                    onChanged: (value){
                        setState(() {
                          
                          value = _dob;

                        });
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(icon: Icon(Icons.calendar_today),onPressed: (){
                             
                        },),
                        labelText: 'DATE OF BIRTH',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),

                 SizedBox(height: 10.0),


                 
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
                      value: _gender,
                      items: _items.map((lable) {
                        return new DropdownMenuItem<String>(
                          value: lable,

                          child: new Text(lable),
                        );
                      }).toList(),
                      hint: Text('Gender'),
                      onChanged: (value) {
                        setState((){
                          _gender = value;
    
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
                           
                            _SOC = value;
                             
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
                           
                            _skills = value;
                             
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
                           
                            _education = value;
                            
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
                           
                            _accountNumber = value;
                             
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
                           
                            _memberNeeded = value;
                             
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