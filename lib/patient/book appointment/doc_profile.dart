import 'package:flutter/material.dart';
import 'package:ooadproject/patient/book%20appointment/book_appointment.dart';
import 'package:ooadproject/welcome.dart';
// import 'package:ooadproject/doctor/medical%20folder/patient_history.dart';

// ignore: camel_case_types
class viewDocProfile extends StatefulWidget {
  viewDocProfile({Key? key, required this.doc, required this.patient})
      : super(key: key);
  Doctor doc;
  Patient patient;
  @override
  State<viewDocProfile> createState() => _viewDocProfileState();
}

// ignore: camel_case_types
class _viewDocProfileState extends State<viewDocProfile> {
  @override
  Widget build(BuildContext context) {
    Doctor doc = widget.doc;
    Patient patient = widget.patient;
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
                        height: 30,
                      ),
                      Text(
                        doc.name,
                        style: const TextStyle(
                            height: 1,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Text(
                        doc.Specialisation,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 2,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(doc.phno,
                              style: const TextStyle(
                                color: Colors.black,
                              )),
                          buildDivider(),
                          Text(doc.email,
                              style: const TextStyle(
                                color: Colors.black,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FlutterDatePickerExample(
                                          doc: doc, patient: patient)));
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          backgroundColor: Colors.green,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Book Appointment',
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
                  Column(
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
                        child: doc.educ_det,
                      )
                    ],
                  )
                ]))));
  }
}
