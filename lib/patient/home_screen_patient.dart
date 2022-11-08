import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ooadproject/patient/medical%20folder/patient_history.dart';
import 'package:ooadproject/patient/book%20appointment/search_dr_tab.dart';
import 'package:ooadproject/patient/my_appointments.dart';
import 'package:ooadproject/welcome.dart';

import 'Pat_prof.dart';

class HomeScreen_patient extends StatefulWidget {
  HomeScreen_patient({super.key, required this.patient, required this.doc});
  Patient patient;
  Doctor doc;
  @override
  State<HomeScreen_patient> createState() => _HomeScreen_patientState();
}

class _HomeScreen_patientState extends State<HomeScreen_patient> {
  CollectionReference users = FirebaseFirestore.instance.collection('Patient');
  static const IconData power_settings_new =
      IconData(0xe4e3, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    Patient patient = widget.patient;
    Doctor doc = widget.doc;
    var cardTextStyle = TextStyle(
        fontFamily: 'AbrilFatface Regular', fontSize: 20, color: Colors.black);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 216, 240, 209),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("VCARE : Patient Portal"),
          automaticallyImplyLeading: false,
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
                              backgroundImage:
                                  AssetImage("assets/images/imgdefault.png")),
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
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(data['Name'],
                                            style: TextStyle(
                                                fontFamily:
                                                    'AbrilFatface Regular',
                                                color: Colors.black87,
                                                fontSize: 20)),
                                        Text(data['Email'],
                                            style: TextStyle(
                                                fontFamily:
                                                    'AbrilFatface Regular',
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
                                      builder: (context) => search_doc(
                                          patient: patient, doc: doc)),
                                ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset(
                                      'assets/images/imgcalendar.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    'Book\nAppointment',
                                    style: cardTextStyle,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )),
                      ),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          child: InkWell(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            patient_history(patient: patient)),
                                  ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Image.asset(
                                        'assets/images/imgfolder.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Medical Folder',
                                      style: cardTextStyle,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ))
                          // )
                          ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          already_booked(patient: patient)),
                                ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset(
                                      'assets/images/imglist.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    'My appointment',
                                    style: cardTextStyle,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => viewPatProf(
                                          doc: doc, patient: patient)),
                                ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset(
                                      'assets/images/imgprofile.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    'Profile',
                                    style: cardTextStyle,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ]))
              ],
            ),
          ))
        ]));
  }
}
