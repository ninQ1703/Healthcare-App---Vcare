import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ooadproject/doctor/edit_doc_dash.dart';
import 'package:ooadproject/welcome.dart';

class viewDocProf extends StatefulWidget {
  viewDocProf({super.key, required this.doc});
  Doctor doc;
  @override
  State<viewDocProf> createState() => _viewDocProfState();
}

// ignore: camel_case_types
class _viewDocProfState extends State<viewDocProf> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Doctor');
    Doctor doc = widget.doc;
    Widget buildDivider() => Container(
          height: 24,
          child: VerticalDivider(),
        );

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 216, 240, 209),
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
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.black),
                            // boxShadow: [
                            //   BoxShadow(
                            //       spreadRadius: 2,
                            //       // blurRadius: ,
                            //       color: Colors.black.withOpacity(0.1),
                            //       offset: const Offset(0, 10))
                            // ],
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
                                  Text(
                                    data['Specialisation'],
                                    style: TextStyle(
                                        height: 2,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(data['contact no'].toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                      buildDivider(),
                                      Text(data['Email'],
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
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
                                  builder: (context) =>
                                      EditProfilePage(doc: doc))).then((value) {
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
                                  color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // buildTextField("Educational Details"),
                    ],
                  ),
                  Container(
                    child: FutureBuilder<DocumentSnapshot>(
                      future: users
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(right: 120.0),
                                  child: Text('Educational Details',
                                      style: TextStyle(
                                          height: 2,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.left)),
                              Padding(
                                  padding: const EdgeInsets.only(right: 100.0),
                                  child: Text(
                                    data['Educational Details'].toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        height: 2,
                                        color: Colors.grey[800],
                                        fontSize: 15),
                                  )),
                              // Text(
                              //   data['Educational Details'].toString(),
                              //   textAlign: TextAlign.start,
                              //   style: TextStyle(
                              //       height: 2,
                              //       color: Colors.grey[800],
                              //       fontSize: 15),
                              // ),
                            ],
                          );
                        }

                        return Text("loading");
                      },
                    ),
                  ),
                ]))));
  }
}
