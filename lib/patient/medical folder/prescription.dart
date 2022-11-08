import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
// import 'package:ooadproject/doc_or_patient.dart';
// import 'package:ooadproject/patient/book%20appointment/search_by_name.dart';
import '../../welcome.dart';

class prescriptionfunc extends StatefulWidget {
  prescriptionfunc({super.key, required this.patient});
  Patient patient;
  @override
  State<prescriptionfunc> createState() => _prescriptionfuncState();
}

class prescriptionText {
  Doctor doc;
  Text prestn;
  prescriptionText.constructor1(this.doc, this.prestn);
}

class _prescriptionfuncState extends State<prescriptionfunc> {
  @override
  Widget build(BuildContext context) {
    Patient patient = widget.patient;
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 216, 240, 209),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: (patient.presriptions.length) * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final j = i ~/ 2;
          return ListTile(
            title: Text(patient.presriptions[j].doc.name),
            subtitle: Text(patient.presriptions[j].pres),
            trailing: Text(DateFormat('MMMM dd, yyyy')
                .format(patient.presriptions[j].time)),
          );
        },
      ),
    );
  }
}
