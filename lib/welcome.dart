import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ooadproject/Login-page.dart';
import 'package:intl/intl.dart';

class Patient {
  String name;
  String phno;
  String email;
  String age;
  String gender;
  List<prescription> presriptions = <prescription>[];
  List<appointmentDetails> Myappointments = <appointmentDetails>[];
  Image prfl = Image.asset("assets/images/imgdefault.png");
  Patient.constructor1(
      this.name, this.phno, this.email, this.prfl, this.age, this.gender);
  Patient.constructor2(this.name, this.phno, this.email, this.age, this.gender);

  void addPrescription(prescription p) {
    presriptions.add(p);
  }

  void addAppointment(appointmentDetails apd) {
    Myappointments.add(apd);
  }
}

class Doctor {
  String name;
  String phno;
  String Specialisation;
  String email;
  Text educ_det;
  Image prfl = Image.asset("assets/images/imgdefault.png");
  List<appointmentDetails> requestlist = <appointmentDetails>[];
  List<appointmentDetails> MyAppointments = <appointmentDetails>[];
  Doctor.constructor1(this.name, this.phno, this.Specialisation, this.email,
      this.prfl, this.educ_det);
  Doctor.constructor2(
      this.name, this.phno, this.Specialisation, this.email, this.educ_det);

  void addrequest(appointmentDetails req) {
    requestlist.add(req);
  }

  void declineRequest(appointmentDetails req) {
    requestlist.remove(req);
  }

  void acceptRequest(appointmentDetails req) {
    MyAppointments.add(req);
    requestlist.remove(req);
  }
}

class prescription {
  String pres;
  Doctor doc;
  DateTime time;
  prescription(this.pres, this.doc, this.time);
}

class appointmentDetails {
  Patient patient;
  Doctor doctor;
  DateTime startTime;
  DateTime endTime;
  int accepted = 0;
  appointmentDetails.constructor(
      this.patient, this.doctor, this.startTime, this.endTime);
  void setStatus(int num) {
    accepted = num;
  }

  Text showStatus() {
    bool doGrey = ((endTime.year < DateTime.now().year) ||
        (endTime.year == DateTime.now().year &&
            endTime.month < DateTime.now().month) ||
        (endTime.year == DateTime.now().year &&
            endTime.month == DateTime.now().month &&
            endTime.day < DateTime.now().day) ||
        (endTime.year == DateTime.now().year &&
            endTime.month == DateTime.now().month &&
            endTime.day == DateTime.now().day &&
            endTime.hour < DateTime.now().hour) ||
        ((endTime.year == DateTime.now().year &&
            endTime.month == DateTime.now().month &&
            endTime.day == DateTime.now().day &&
            endTime.hour == DateTime.now().hour &&
            endTime.minute < DateTime.now().minute)));
    if (doGrey && accepted != 3) {
      setStatus(2);
    }
    if (accepted == 0) {
      return const Text(
        "Request sent",
        style: TextStyle(color: Color.fromARGB(255, 236, 118, 110)),
      );
    } else if (accepted == 1) {
      return const Text("Accepted", style: TextStyle(color: Colors.green));
    } else if (accepted == 3) {
      return const Text("Declined", style: TextStyle(color: Colors.red));
    } else {
      return const Text("Ended",
          style: TextStyle(color: Color.fromARGB(255, 98, 95, 95)));
    }
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Doctor doc = Doctor.constructor2(
      "Dr Archana Joshi",
      "8765433456",
      "Psychiatrist",
      "ajoshi@gmail.com",
      Text("MBBS, AIIMS Rishikesh"
          "MD, CMC Vellore"
          "DPM, Central Institute of Psychiatry, Ranchi"));
  Patient patient = Patient.constructor2(
      "Ajay Verma", "9873234553", "ajv@gmail.com", "25", "Male");
  DateFormat dateDisplay = DateFormat("MMMM dd, yyyy");
  DateFormat timeDisplay = DateFormat("hh : mm  a");
  @override
  void initState() {
    // TODO: implement initState
    getAppointmentList(doc);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/appicon.jpg'),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
              child: Container(
            width: double.maxFinite,
            height: 100,
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'VCare',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 6.0,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ],
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    'Because We Care',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 6.0,
                          color: Colors.green,
                        ),
                      ],
                      // fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ]),
          )),
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp1(patient: patient, doc: doc)));
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Continue',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color.fromARGB(255, 76, 175, 116),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getAppointmentList(Doctor doc) {
    Patient p1 = Patient.constructor2(
        "Raj Agarwal", "9876543256", "ragarwal@gmail.com", "18", "Male");
    doc.addrequest(appointmentDetails.constructor(p1, doc,
        DateTime(2022, 11, 10, 9, 0, 0), DateTime(2022, 11, 10, 10, 0, 0)));
    // Patient p0 =
    //     (Patient.constructor2("Neha Gujar", "9876543467", "ngujar@gmail.com"));
    doc.addrequest(appointmentDetails.constructor(patient, doc,
        DateTime(2022, 11, 10, 11, 0, 0), DateTime(2022, 11, 10, 12, 0, 0)));
    Patient p2 = Patient.constructor2(
        "Sunidhi Kumar", "9567898954", "skumar@gmail.com", "18", "Female");
    doc.addrequest(appointmentDetails.constructor(p2, doc,
        DateTime(2022, 11, 10, 17, 0, 0), DateTime(2022, 11, 10, 18, 0, 0)));
    Patient p3 = (Patient.constructor2(
        "Harish Singh", "9845766356", "hsingh@gmail.com", "18", "Male"));
    doc.addrequest(appointmentDetails.constructor(p3, doc,
        DateTime(2022, 11, 11, 10, 0, 0), DateTime(2022, 11, 11, 11, 0, 0)));
    Patient p4 = (Patient.constructor2(
        "Kapil Jain", "9876545677", "kjain@gmail.com", "18", "Male"));
    doc.addrequest(appointmentDetails.constructor(p4, doc,
        DateTime(2022, 11, 11, 14, 0, 0), DateTime(2022, 11, 11, 15, 0, 0)));
    Patient p5 = (Patient.constructor2(
        "Kriti Mehta", "9899765446", "kmehta@gmail.com", "18", "Female"));
    doc.addrequest(appointmentDetails.constructor(p5, doc,
        DateTime(2022, 11, 12, 10, 0, 0), DateTime(2022, 11, 12, 11, 0, 0)));
    Patient p6 = (Patient.constructor2(
        "Shiv Patel", "8897553256", "apatel@gmail.com", "18", "Male"));
    doc.addrequest(appointmentDetails.constructor(p6, doc,
        DateTime(2022, 11, 12, 11, 0, 0), DateTime(2022, 11, 12, 12, 0, 0)));
    Patient p7 = (Patient.constructor2(
        "Bhav Vaibhav", "7875443256", "bvaibhav@gmail.com", "18", "Male"));
    doc.addrequest(appointmentDetails.constructor(p7, doc,
        DateTime(2022, 11, 13, 9, 0, 0), DateTime(2022, 11, 13, 10, 0, 0)));
    Patient p8 = (Patient.constructor2(
        "Aziz Khan", "9777273356", "akhan@gmail.com", "18", "Male"));
    doc.addrequest(appointmentDetails.constructor(p8, doc,
        DateTime(2022, 11, 14, 12, 0, 0), DateTime(2022, 11, 14, 13, 0, 0)));
    Patient p9 = (Patient.constructor2(
        "Priya Wangdu", "9876543256", "pwangdu@gmail.com", "18", "Female"));
    doc.addrequest(appointmentDetails.constructor(p9, doc,
        DateTime(2022, 11, 14, 10, 0, 0), DateTime(2022, 11, 14, 11, 0, 0)));
  }
}
