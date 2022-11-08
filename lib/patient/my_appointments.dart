import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ooadproject/welcome.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class already_booked extends StatefulWidget {
  already_booked({super.key, required this.patient});
  Patient patient;
  @override
  State<already_booked> createState() => _already_bookedState();
}

class _already_bookedState extends State<already_booked> {
  // MyappointmentList[1].setStatus(1);
  @override
  Widget build(BuildContext context) {
    Patient patient = widget.patient;
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 216, 240, 209),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("My Appointments"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView.builder(
          itemCount: (patient.Myappointments.length) * 2,
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();

            final j = i ~/ 2;

            // if (index < MyPatientList.length) {
            return ListTile(
              // leading: MyappointmentList[j].,
              title: Text(
                DateFormat('MMMM dd, yyyy   hh:mm a')
                    .format(patient.Myappointments[j].startTime),
                style: TextStyle(color: Colors.black87),
              ),
              subtitle: Text(patient.Myappointments[j].doctor.name),
              trailing: patient.Myappointments[j].showStatus(),
            );
            // }
          },
        ));
    ;
  }
}
