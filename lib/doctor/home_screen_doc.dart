import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ooadproject/doctor/doc_prof.dart';
import 'package:ooadproject/doctor/patient%20list/Patients.dart';
import 'package:ooadproject/doctor/schedule.dart';
import 'package:ooadproject/doctor/requests.dart';
import 'package:ooadproject/welcome.dart';


class HomeScreen_doc extends StatefulWidget {
  HomeScreen_doc({super.key, required this.doc});
  Doctor doc;
  @override
  State<HomeScreen_doc> createState() => _HomeScreen_docState();
}

class _HomeScreen_docState extends State<HomeScreen_doc> {
  CollectionReference users = FirebaseFirestore.instance.collection('Doctor');
  static const IconData power_settings_new =
  IconData(0xe4e3, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    Doctor doc = widget.doc;
    var cardTextStyle = TextStyle(
        fontFamily: 'AbrilFatface Regular', fontSize: 20, color: Colors.black);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          title: const Text("VCARE : Doctor Portal"),
          elevation: 3,
        ),
        body: Stack(children: <Widget>[
          Positioned(
            top: 10.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(power_settings_new),
                  hoverColor: Colors.red,
                  onPressed: () => Navigator.of(context).pop()),
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                    height: 64,
                    margin: const EdgeInsets.only(bottom: 100),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 32,
                            backgroundImage: AssetImage("assets/images/imgdefault.png")
                          ),
                          const SizedBox(
                            width: 16,
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text( data['Name'],
                                            style: TextStyle(
                                                fontFamily: 'AbrilFatface Regular',
                                                color: Colors.black87,
                                                fontSize: 20)),
                                        Text(data['Email'],
                                            style: TextStyle(
                                                fontFamily: 'AbrilFatface Regular',
                                                color: Colors.black54)),
                                      ]);
                                }
                                return Text("loading");
                              },
                            ),
                          ),
                        ])),
                Expanded(
                    child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        primary: false,
                        crossAxisCount: 2,
                        children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          viewDocProf(doc: doc)),
                                ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset(
                                      'assets/images/imgdoctor.png',
                                      // height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // Expanded(
                                  Text(
                                    'Profile',
                                    style: cardTextStyle,
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                  )
                                  // )
                                ],
                              ),
                            )),
                        // child: Expanded(

                        // )
                      ),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          // child: Expanded(
                          child: InkWell(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Patients(doc: doc)),
                                  ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Image.asset(
                                        'assets/images/imgpatients.jpg',
                                        // height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    // Expanded(
                                    //     child: Padding(
                                    //         padding:
                                    //             EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    Text(
                                      'Patients',
                                      style: cardTextStyle,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                    )
                                    // ))
                                  ],
                                ),
                              ))
                          // )
                          ),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          // child: Expanded(
                          child: InkWell(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AppointmentWithoutWeekends(
                                                doc: doc)),
                                  ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Image.asset(
                                        'assets/images/imgcalender.jpg',
                                        // height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    // Expanded(
                                    //     child: Padding(
                                    //         padding:
                                    //             EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    Text(
                                      'Appointments',
                                      style: cardTextStyle,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                    )
                                    // ))
                                  ],
                                ),
                              ))
                          // )
                          ),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          // child: Expanded(
                          child: InkWell(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyRequests(doc: doc)),
                                  ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Image.asset(
                                        'assets/images/imgrequests.png',
                                        // height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    // Expanded(
                                    //     child: Padding(
                                    //         padding:
                                    //             EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    Text(
                                      'Requests',
                                      style: cardTextStyle,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                    )
                                    // ))
                                  ],
                                ),
                              ))
                          // )
                          ),
                    ]))
              ],
            ),
          ))
        ]));
  }
}
