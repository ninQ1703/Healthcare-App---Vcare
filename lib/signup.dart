import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login-page.dart';
import 'welcome.dart';
//import 'Doctor-pages/edit_profile_doc.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  SignupPage({Key? key, required this.patient, required this.doc}) : super(key: key);
  Doctor doc;
  Patient patient;
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _sucess = false;
  late String _userEmail;

  @override
  Widget build(BuildContext context) {
    Patient patient = widget.patient;
    Doctor doc = widget.doc;
    void goToLogin() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Login page',doc: doc,patient: patient)),
      );
    }

    void _register(String u) async {
      var user;
      if(u=="Doctor" || u=="doctor"){
      user = _auth
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        FirebaseFirestore.instance
            .collection('Doctor')
            .doc(value.user?.uid)
            .set({"Email": value.user?.email,
          "Name": "",
          "Doctor": u,
            });
      });}
      else if(u=="Patient" || u=="patient"){
        user = _auth
            .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
            .then((value) {
          FirebaseFirestore.instance
              .collection('Patient')
              .doc(value.user?.uid)
              .set({"Email": value.user?.email,
            "Name": "",
            "Patient": u,
          });
        });
      }
      else user = null;

      if (user != null) {
        setState(() {
          _sucess = true;
        });
      } else {
        setState(() {
          _sucess = false;
        });
      }
      if (_sucess) goToLogin();
    }

    String ty="";
    return new Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: Text("SignUp",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 35, left: 20, right: 30),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    )),
                obscureText: true,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                onChanged: (value) {
                  ty = value;
                },
                decoration: InputDecoration(
                    labelText: 'Doctor/Patient',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    _register(ty);
                  },
                  child: const Text("SIGN UP",
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 2.2,
                          color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // foreground
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Go Back',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
