import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:ooadproject/doctor/medical%20folder/write_prescription.dart';
import 'package:ooadproject/welcome.dart';

class prescriptionfunc extends StatefulWidget {
  prescriptionfunc({super.key, required this.patient, required this.doc});
  Patient patient;
  Doctor doc;
  @override
  State<prescriptionfunc> createState() => _prescriptionfuncState();
}

class _prescriptionfuncState extends State<prescriptionfunc> {
  List<Text> pres = [Text("HI"), Text("hello")];

  @override
  Widget build(BuildContext context) {
    Patient patient = widget.patient;
    Doctor doc = widget.doc;
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        write_prescription(patient: patient, doc: doc)))
                .then((value) {
              setState(() {});
            });
          },
          child: Icon(Icons.add)),
    );
  }
}