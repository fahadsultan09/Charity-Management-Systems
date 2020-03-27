import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notifier/Login/Authentication.dart';
import 'package:notifier/Login/SignUpPage2.dart';
import 'package:notifier/Models/UserClass.dart';
import 'package:toast/toast.dart';



class SignupPage extends StatefulWidget {

   final BaseAuth auth;

  SignupPage({this.auth});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
   String villageGroup = "SELECT THE OPTION";
  User user;
  bool disable = false;
   List<DocumentSnapshot> documents;
   String selected;
  bool obsureTextValue = true;

  Future<void> getReciever() async{
   final QuerySnapshot result = await Firestore.instance.collection("Users").getDocuments();
  documents = result.documents.toList();
  documents.forEach((data){

    _items.add(data.documentID.toString());
    
  });
  }
  void _ChangeText(){
    setState(() {
     if(obsureTextValue){
       obsureTextValue = false;

     }
     else{
       obsureTextValue = true;

     }
    });
  }
  List<String> _items = [];
String gender = "Male";
List<String> _genderitems = ["Male","Female"];
List<String> villageGroupitems = ["Bhawalnagar","Mailsi","Faisalabad","Karachi","Patoki"];
List<String > familygrp = ["01","02","03","04","05"];
  final _formKey = new GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid");
      return true;
    }
    return false;
  }
  Future validateAndSubmit () async {
    
    if (validateAndSave()){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage2(user)));
     
        }
    
      }

 

  @override
  void initState() {
     user = new User();
    getReciever();

    super.initState();
    
    
    
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (input) => input.isEmpty ? 'Name cannot be empty' : null,
                      onChanged: (value){
                          
                            user.fullName = value;
                          },
                    decoration: InputDecoration(
                      labelText: 'FULL NAME ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                        
                        
                  ),
                  
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                      validator: (input) => input.isEmpty ? 'Email cannot be empty' : null,
                      onChanged: (value){
                           
                            user.email = value;
                    
                          },
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
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
                      validator: (input) => input.isEmpty ? 'Password cannot be empty' : null,
                      onChanged: (value){
                           
                            user.password = value;


                          },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(icon: new Icon(Icons.remove_red_eye),onPressed: _ChangeText ,color: Colors.grey,),
                        labelText: 'PASSWORD(Minimum 6 characters)',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                            
                    obscureText: obsureTextValue,
                  ),
                  SizedBox(height: 10.0),
                  
                     TextFormField(

                    keyboardType: TextInputType.number,
                      validator: (input) => input.isEmpty ? 'Phone Number cannot be empty' : null,
                      onChanged: (value){
                           
                            user.phoneNum = value;
                          },
                    decoration: InputDecoration(
                        hintText: "03XX-XXXXXX", 
                        labelText: 'PHONE NO.',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 SizedBox(height: 20.0),

                 Container(
                width: MediaQuery.of(context).size.width-50,
                height: 60.0,
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.blueGrey),
                    
                ),
                child : DropdownButtonHideUnderline(

                  child: ButtonTheme(
                    
                    alignedDropdown: true,
                    child: new DropdownButton<String>(
                      value: gender,
                      items: _genderitems.map((lable) {
                        return new DropdownMenuItem<String>(
                          value: lable,

                          child: new Text(lable),
                        );
                      }).toList(),
                      hint: Text('Gender'),
                      onChanged: (value) {
                        setState((){
                     
                            user.gender = value;

                            print(user.gender);
                        });
                        
                      },
                    ),
                  ),
              ),
              ),
               SizedBox(height: 20.0),

                Container(
                width: MediaQuery.of(context).size.width-50,
                height: 60.0,
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.blueGrey),
                ),
                child : DropdownButtonHideUnderline(

                  child: ButtonTheme(
                    
                    alignedDropdown: true,
                    child: new DropdownButton<String>(
                      
                      items: villageGroupitems.map((lable) {
                        return new DropdownMenuItem<String>(
                          value: lable,

                          child: new Text(lable),
                        );
                      }).toList(),
                      hint: Text('Village Group'),
                      onChanged: (value) {
                        setState((){
                          user.villageGroup = value;
                          Toast.show(user.villageGroup+" selected", context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.green[500]);
                        });
                        
                      },
                    ),
                  ),
              ),
              ),
               SizedBox(height: 20.0),

                Container(
                width: MediaQuery.of(context).size.width-50,
                height: 60.0,
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.blueGrey),
                ),
                child : DropdownButtonHideUnderline(

                  child: ButtonTheme(
                    
                    alignedDropdown: true,
                    child: new DropdownButton<String>(
                      
                      items: familygrp.map((lable) {
                        return new DropdownMenuItem<String>(
                          value: lable,

                          child: new Text(lable),
                        );
                      }).toList(),
                      hint: Text('Family Group'),
                      onChanged: (value) {
                        setState((){
                          user.familyGroup = value;
                          Toast.show(user.familyGroup+" selected", context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.green[500]);
                        });
                        
                      },
                    ),
                  ),
              ),
              ),
              
                  SizedBox(height: 50.0),
                 

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                     Container(
                
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.blueGrey)
                ),
                child : DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: new DropdownButton<String>(
                      value: selected,
                      items: _items.map((lable) {
                        return new DropdownMenuItem<String>(
                          value: lable,
                          child: new Text(lable),
                        );
                      }).toList(),
                      hint: Text('FATHER NAME'),
                      onChanged: (value) {
                        
                        setState((){
                          selected = value;
                          user.fatherName = selected;
                        });
                        
                      },
                    ),
                  ),
              ),
              ),

              FlatButton(color: Colors.grey,onPressed: (){
                setState(() {
                  if(disable==false){
                    disable = true;
                  }
                  else{
                    disable = false;
                  }
                });
              }, child: Text("NEW"))

                  ],
                ),

  SizedBox(height: 10.0),
                
                TextFormField(
                  enabled: disable,
                    keyboardType: TextInputType.text,
                      validator: (input) => user.fatherName.isEmpty ? 'FATHER NAME cannot be empty' : null,
                      onChanged: (value){
                           
                            user.fatherName = value;
                            
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'FATHER NAME',
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
                      validator: (input) => input.isEmpty ? 'Father Status cannot be empty' : null,
                      onChanged: (value){
                           
                            user.fatherStatus = value;
                            
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'FAMILY STATUS',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 SizedBox(height: 10.0),


              GestureDetector(
                  onTap: validateAndSubmit,
                  child:  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                     
                          child: Center(
                            child: Text(
                              'NEXT',
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