import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notifier/Login/Authentication.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notifier/Login/SignUpPage2.dart';



class SignupPage extends StatefulWidget {

   final BaseAuth auth;

  SignupPage({this.auth});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool disable = false;
   List<DocumentSnapshot> documents;
   String selected;
  bool obsureTextValue = true;
  FirebaseMessaging fcm = FirebaseMessaging();
  Future<void> getReciever() async{
   final QuerySnapshot result = await Firestore.instance.collection("Users").getDocuments();
  documents = result.documents.toList();
  documents.forEach((data){
    print(data.documentID);
    _items.add(data.documentID.toString());
    // myBatch.add(data.documentID.toString());
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
  String _fullName="";
  String _email="";
  String _password="";
  String _phoneNum="";
  String _fcm="";
  int amount = 0;
  String _fatherName ="";
  String _fatherStatus ="";
  String _familyGroup ="";
  String _villageGroup ="";



  final _formKey = new GlobalKey<FormState>();
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final DateFormat format = DateFormat("yyyy-MM-dd");

  Future validateAndSubmit () async {
    
    if (true){
      try {
    //  AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password:_password);
                     
          AuthResult _user =  (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password:_password));
          
   

        // Firestore _firestore = Firestore.instance;
      if(_user!=null){


          Firestore _firestore = Firestore.instance;
           _firestore.collection("Users").document(_fatherName).setData({"1":1});
        _firestore.collection("Users").document(_fatherName).collection("children").document(_user.user.uid).setData(
        {"Email": _email,
        "Full Name": _fullName,
        "Phone": _phoneNum,
        "Father Name":_fatherName,
        "Family Status":_fatherStatus,
        "Family Group":_familyGroup,
        "Village Group":_villageGroup,
        "Amount":amount,
        "token":_fcm,
      });
      _firestore.collection("Users2").document(_user.user.uid).setData(
        {"Email": _email,
        "Full Name": _fullName,
        "Phone": _phoneNum,
        "Father Name":_fatherName,
        "Family Status":_fatherStatus,
        "Family Group":_familyGroup,
        "Village Group":_villageGroup,
        "token":_fcm,
        "Amount":amount,
      });

      _firestore.collection("DonorCurrentPayment").document(_user.user.uid).setData({
        "Amount":amount,
      });

      
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage2(_user.user.uid,_fatherName)));
       } 
    
   

          }
          catch (e){
    
           Scaffold.of(context).showSnackBar(SnackBar(content: Text("USER NOT CREATED")));

        }
        }
    
      }

  void _saveDeviceToken() async{
    _fcm = await fcm.getToken();

  }
 

  @override
  void initState() {
    getReciever();
    _saveDeviceToken();
    super.initState();
    
    
    
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (input) => input.isEmpty ? 'Name cannot be empty' : null,
                      onChanged: (value){
                           
                            _fullName = value;
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
                  // SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                      validator: (input) => input.isEmpty ? 'Email cannot be empty' : null,
                      onChanged: (value){
                           
                            _email = value;
                    
                          },
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Password cannot be empty' : null,
                      onChanged: (value){
                           
                            _password = value;


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
                           
                            _phoneNum = value;
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
                 SizedBox(height: 10.0),

                TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'VILLAGE GROUP cannot be empty' : null,
                      onChanged: (value){
                           
                            _villageGroup = value;
                            print(_villageGroup);
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'VILLAGE GROUP',
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
                      validator: (input) => input.isEmpty ? 'Family Group Number cannot be empty' : null,
                      onChanged: (value){
                           
                            _familyGroup = value;
                            print(_familyGroup);
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'FAMILY GROUP',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 

                  SizedBox(height: 50.0),
                 

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                     Container(
                // width: 200.0,
                // height: 60.0,
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
                          _fatherName = selected;
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
                      validator: (input) => input.isEmpty ? 'FATHER NAME cannot be empty' : null,
                      onChanged: (value){
                           
                            _fatherName = value;
                            print(_fatherName);
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
                           
                            _fatherStatus = value;
                            print(_fatherStatus);
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