import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ooadproject/doctor/medical%20folder/patient_history.dart';
import 'package:ooadproject/welcome.dart';
import 'package:ooadproject/doctor/patient%20list/patient_profile.dart';
import 'package:ooadproject/patient/my_appointments.dart';

class Patients extends StatefulWidget {
  Patients({super.key, required this.doc});
  Doctor doc;
// patients
  // final _patientlist = MyPatient[];
  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  Widget build(BuildContext context) {
    Doctor doc = widget.doc;
    return Scaffold(
        appBar: AppBar(
          title: Text("My Patients"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView.builder(
          itemCount: (doc.MyAppointments.length) * 2,
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();

            final j = i ~/ 2;

            // if (index < MyPatientList.length) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => viewPatientProfile(patient: doc.MyAppointments[j].patient,doc: doc,)));
              },
              leading: doc.MyAppointments[j].patient.prfl,
              title: Text(
                doc.MyAppointments[j].patient.name,
                style: TextStyle(color: Colors.black87),
              ),
              subtitle: Text(doc.MyAppointments[j].patient.phno),
            );
            // }
          },
        ));
  }
}
