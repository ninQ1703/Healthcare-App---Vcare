import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ooadproject/welcome.dart';
import 'edit_pat_dash.dart';

class viewPatProf extends StatefulWidget {
  viewPatProf({super.key, required this.doc, required this.patient});
  Doctor doc;
  Patient patient;
  @override
  State<viewPatProf> createState() => _viewPatProfState();
}

// ignore: camel_case_types
class _viewPatProfState extends State<viewPatProf> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Patient');
    Doctor doc = widget.doc;
    Patient patient = widget.patient;
    Widget buildDivider() => Container(
          height: 24,
          child: VerticalDivider(),
        );

    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 216, 240, 209),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Profile"),
          // Theme.of(context).scaffoldBackgroundColor,
          elevation: 3,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(
                    left: 16, top: 25, right: 16, bottom: 12),
                // child: Align(
                //   alignment: Alignment.topCenter,
                child: Column(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const SizedBox(
                      //   height: 35,
                      // ),
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  // blurRadius: ,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/imgdefault.png',
                                ))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: FutureBuilder<DocumentSnapshot>(
                          future: users
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    data['Name'],
                                    style: TextStyle(
                                        height: 1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        data['contact no'].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      buildDivider(),
                                      Text(data['Email'],
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          "Age: " +
                                              data['Age'].toString() +
                                              " Yrs",
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Gender: " + data['Gender'],
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ]),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              );
                            }

                            return Text("loading");
                          },
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                      patient: patient,
                                      doc: doc))).then((value) {
                            setState(() {});
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          backgroundColor: Colors.green,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Edit Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  // height: 2,
                                  fontSize: 17,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 12, 12, 12))),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // buildTextField("Educational Details"),
                    ],
                  ),
                ]))));
  }
}
