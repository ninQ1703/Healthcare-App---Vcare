import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:ooadproject/doctor/medical%20folder/write_prescription.dart';
import 'package:ooadproject/welcome.dart';

class medRepfunc extends StatefulWidget {

  @override
  State<medRepfunc> createState() => _medRepfuncState();
}

class _medRepfuncState extends State<medRepfunc> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      floatingActionButton: FloatingActionButton(

          onPressed: null,
          child: Icon(Icons.add)),
    );
  }
}