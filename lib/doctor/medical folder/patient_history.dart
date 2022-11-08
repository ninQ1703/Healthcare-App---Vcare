import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ooadproject/welcome.dart';
import 'package:ooadproject/doctor/medical%20folder/prescription.dart';

import 'medical_report.dart';

// ignore: camel_case_types
class patient_history extends StatefulWidget {
  patient_history({super.key, required this.patient, required this.doc});
  Patient patient;
  Doctor doc;
  @override
  State<patient_history> createState() => _patient_historyState();
}

// ignore: camel_case_types
class _patient_historyState extends State<patient_history> {
  @override
  Widget build(BuildContext context) {
    Patient patient = widget.patient;
    Doctor doc = widget.doc;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(text: "Prescription"),
              Tab(
                text: "Medical Reports",
              )
            ]),
            title: const Text('Medical Folder'),
          ),
          body: TabBarView(children: [
            prescriptionfunc(patient: patient, doc:  doc,),
            medRepfunc(),
          ]),
        ));
  }
}


// ignore: camel_case_types
// class prescripton extends StatelessWidget {
//   const prescripton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//     );
//   }
// }
// class medical_history extends StatelessWidget {
//   const medical_history({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("hello"),
//     );
//   }
// }
