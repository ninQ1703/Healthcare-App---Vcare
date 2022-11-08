import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'welcome.dart';
import 'patient/edit_patient.dart';
import 'patient/home_screen_patient.dart';
import 'doctor/edit_profile_doc.dart';
import 'firebase_options.dart';
import 'doctor/home_screen_doc.dart';
import 'signup.dart';
import 'package:intl/intl.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyApp1 extends StatelessWidget {
  MyApp1({Key? key, required this.patient, required this.doc})
      : super(key: key);
  Doctor doc;
  Patient patient;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(
          title: 'Flutter Demo Home Page', doc: doc, patient: patient),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) =>
            new SignupPage(doc: doc, patient: patient)
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {Key? key, required this.title, required this.patient, required this.doc})
      : super(key: key);
  Doctor doc;
  Patient patient;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _success = 1;
  String _userEmail = "";

  Widget build(BuildContext context) {
    Doctor doc = widget.doc;
    Patient patient = widget.patient;
    void goToProfile(String qr) {
      if (qr == "Doctor" || qr == "doctor") {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditProfilePage_doc(doc: doc)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EditProfilePage_pat(doc: doc, patient: patient)),
        );
      }
    }

    void goToHomescreen(String qr) {
      if (qr == "Doctor" || qr == "doctor") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen_doc(doc: doc)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen_patient(doc: doc, patient: patient)),
        );
      }
    }

    void _singIn(String u) async {
      final User? user = (await _auth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text))
          .user;

      if (user != null) {
        setState(() {
          _success = 2;
          _userEmail = user.email!;
        });
      } else {
        setState(() {
          _success = 3;
        });
      }
      if (_success == 2) {
        CollectionReference? users;
        if (u == "Doctor" || u == "doctor") {
          users = FirebaseFirestore.instance.collection('Doctor');
        } else if (u == "Patient" || u == "patient") {
          users = FirebaseFirestore.instance.collection('Patient');
        } else {
          users = null;
        }

        if (users != null) {
          final docRef = users.doc(FirebaseAuth.instance.currentUser?.uid);
          docRef.get().then(
            (DocumentSnapshot doc) {
              final data = doc.data() as Map<String, dynamic>;
              if (data['Name'] == "")
                goToProfile(u);
              else
                goToHomescreen(u);
            },
            onError: (e) => print("Error getting document: $e"),
          );
        } else
          print("Error");
      }
    }

    String po = "";
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 216, 240, 209),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                    child: Text("Welcome",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)),
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
                      po = value;
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
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _success == 1
                            ? ''
                            : (_success == 2 ? '' : 'Sign in failed'),
                        style: TextStyle(color: Colors.red),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        _singIn(po);
                      },
                      child: const Text("LOGIN",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2.2,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // foreground
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
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: Text('Register',
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
