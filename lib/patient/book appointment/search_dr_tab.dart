// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ooadproject/patient/book%20appointment/search_by_specialisation.dart';
import 'package:ooadproject/patient/book%20appointment/search_by_name.dart';
import 'package:ooadproject/welcome.dart';

// ignore: camel_case_types
class search_doc extends StatefulWidget {
  search_doc({Key? key, required this.patient, required this.doc})
      : super(key: key);
  Patient patient;
  Doctor doc;
  @override
  State<search_doc> createState() => _search_docState();
}

// ignore: camel_case_types
class _search_docState extends State<search_doc> {
  List<Doctor> searchTerms = [
    Doctor.constructor2("Dr Shalini veda", "9987654789", "psychiatrist",
        "sveda@gmail.com", Text("MBBS,\nAIIMS Rishikesh")),
    Doctor.constructor2("Dr Vedik gosh", "2345622", "General practitioner",
        "vghosh2gmail.com", Text("MBBS,\nAIIMS Rishikesh")),
    Doctor.constructor2("Dr Amedi shah", "98765434567", "Orthopedics",
        "ashah@gmail.com", Text("MBBS,\nAIIMS Rishikesh")),
    Doctor.constructor2("Dr Noor Ahmed", "98765434567", "Neurologist",
        "sahmed@gmail.com", Text("MBBS,\nAIIMS Rishikesh")),
    Doctor.constructor2("Dr Rahul Dariya", "8765433456", "Dermatologist",
        "rdariya@gmail.com", Text("MBBS,\nAIIMS Rishikesh")),
    Doctor.constructor2("Dr Meghna Raj", "987445676", "Oncologist",
        "mraj@gmail.com", Text("MBBS,\nAIIMS Rishikesh")),
    Doctor.constructor2("Dr Paresh Kumar", "98765434567", "General Pracitioner",
        "pkumar@gmail.com", Text("MBBS,\nAIIMS Rishikesh")),
    Doctor.constructor2("Dr Jeet Singh", "87654567887", "Nephrologist",
        "jsingh@gmail.com", Text("MBBS,\nAIIMS Rishikesh")),
  ];
  void initState() {
    // TODO: implement initState
    addDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Patient patient = widget.patient;
    Doctor doc = widget.doc;
    // var size = MediaQuery.of(context).size;
    var cardTextStyle = const TextStyle(
        fontFamily: 'AbrilFatface Regular', fontSize: 20, color: Colors.black);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 216, 240, 209),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Book Appointment"),
          // Theme.of(context).scaffoldBackgroundColor,
          elevation: 3,
          //   leading: IconButton(
          //     icon: const Icon(
          //       Icons.arrow_back,
          //       color: Colors.white,
          //     ),
          //     onPressed: () => Navigator.of(context).pop(),
          //   ),
        ),
        body: Stack(children: <Widget>[
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                const Center(
                    child: Text('Search Doctor...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25))),
                const SizedBox(
                  height: 45,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => search_name(
                                patient: patient,
                                doc: doc,
                                searchTerms: searchTerms)));
                  },
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      backgroundColor: Color.fromARGB(253, 96, 199, 77),
                      minimumSize: Size(500, 50),
                      side: const BorderSide(
                          color: Color.fromARGB(84, 33, 149, 243), width: 1)),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('By Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // height: 2,
                            fontSize: 20,
                            letterSpacing: 1,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => search_spec(
                                  patient: patient,
                                  doc: doc,
                                  searchTerms: searchTerms,
                                )));
                  },
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      backgroundColor: Color.fromARGB(253, 96, 199, 77),
                      minimumSize: Size(500, 50),
                      side: const BorderSide(
                          color: Color.fromARGB(84, 33, 149, 243), width: 1)),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('By Specialisation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // height: 2,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ))
        ]));
  }

  void addDoc() {
    searchTerms.add(widget.doc);
  }
}
