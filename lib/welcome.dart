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
  Patient.constructor1(this.name, this.phno, this.email, this.prfl,this.age,this.gender);
  Patient.constructor2(this.name, this.phno, this.email,this.age,this.gender);

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
  Doctor.constructor1(
      this.name, this.phno, this.Specialisation, this.email, this.prfl, this.educ_det);
  Doctor.constructor2(this.name, this.phno, this.Specialisation, this.email, this.educ_det);

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

// ignore: camel_case_types
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => WelcomeState();
}

// ignore: camel_case_types
class WelcomeState extends State<Welcome> {
  Doctor doc = Doctor.constructor2(
      "Dr Komal Gupta", "8765433456", "Psychiatrist", "kgupta@gmail.com",
        Text("MBBS,"
            "AIIMS Rishikesh")
  );
  Patient patient =
      Patient.constructor2("Ajay Verma", "9873234553", "ajv@gmail.com","25","Male");
  DateFormat dateDisplay = DateFormat("MMMM dd, yyyy");
  DateFormat timeDisplay = DateFormat("hh : mm  a");
  @override
  void initState() {
    // TODO: implement initState
    getAppointmentList(doc);
    super.initState();
  }

  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    var cardTextStyle = const TextStyle(
        fontFamily: 'AbrilFatface Regular', fontSize: 20, color: Colors.black);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Sign in"),
          // Theme.of(context).scaffoldBackgroundColor,
          elevation: 3,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(children: <Widget>[
          // const SizedBox(
          //   height: double.infinity,
          //   width: double.infinity,
          // ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 40,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyApp1(patient: patient, doc: doc)));
                  },
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      backgroundColor: Color.fromARGB(77, 156, 227, 247),
                      minimumSize: Size(500, 50),
                      side: const BorderSide(
                          color: Color.fromARGB(84, 33, 149, 243), width: 1)),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('Welcome!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // height: 2,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 12, 12, 12))),
                  ),
                ),
              ],
            ),
          ))
        ]));
  }

  Doctor getDoctor() {
    return doc;
  }

  void getAppointmentList(Doctor doc) {
    Patient p1 =
        Patient.constructor2("Mehak Sharma", "9876543256", "msharma@gmail.com","18","Female");
    doc.addrequest(appointmentDetails.constructor(p1, doc,
        DateTime(2022, 11, 8, 9, 0, 0), DateTime(2022, 11, 8, 10, 0, 0)));
    // Patient p0 =
    //     (Patient.constructor2("Neha Gujar", "9876543467", "ngujar@gmail.com"));
    doc.addrequest(appointmentDetails.constructor(patient, doc,
        DateTime(2022, 11, 8, 11, 0, 0), DateTime(2022, 11, 8, 12, 0, 0)));
    Patient p2 = Patient.constructor2(
        "Manashree Kalode", "9567898954", "mKalode@gmail.com","18","Female");
    doc.addrequest(appointmentDetails.constructor(p2, doc,
        DateTime(2022, 11, 8, 17, 0, 0), DateTime(2022, 11, 8, 18, 0, 0)));
    Patient p3 = (Patient.constructor2(
        "Nishita Singh", "9845766356", "nSingh@gmail.com","18","Female"));
    doc.addrequest(appointmentDetails.constructor(p3, doc,
        DateTime(2022, 11, 9, 10, 0, 0), DateTime(2022, 11, 9, 11, 0, 0)));
    Patient p4 = (Patient.constructor2(
        "Kashish Prakash", "9876545677", "kPrakash@gmail.com","18","Female"));
    doc.addrequest(appointmentDetails.constructor(p4, doc,
        DateTime(2022, 11, 9, 14, 0, 0), DateTime(2022, 11, 9, 15, 0, 0)));
    Patient p5 = (Patient.constructor2(
        "Akansha Swati", "9899765446", "ASwati@gmail.com","18","Female"));
    doc.addrequest(appointmentDetails.constructor(p5, doc,
        DateTime(2022, 11, 10, 10, 0, 0), DateTime(2022, 11, 10, 11, 0, 0)));
    Patient p6 = (Patient.constructor2(
        "Aarya Aggarwal", "8897553256", "aAgarwal@gmail.com","18","Female"));
    doc.addrequest(appointmentDetails.constructor(p6, doc,
        DateTime(2022, 11, 10, 11, 0, 0), DateTime(2022, 11, 10, 12, 0, 0)));
    Patient p7 = (Patient.constructor2(
        "Shinjan Chaturvedi", "7875443256", "sChaturvedi@gmail.com","18","Female"));
    doc.addrequest(appointmentDetails.constructor(p7, doc,
        DateTime(2022, 11, 12, 9, 0, 0), DateTime(2022, 11, 12, 10, 0, 0)));
    Patient p8 = (Patient.constructor2(
        "Shreya Shivkumar", "9777273356", "sShivkumar@gmail.com","18","Female"));
    doc.addrequest(appointmentDetails.constructor(p8, doc,
        DateTime(2022, 11, 11, 12, 0, 0), DateTime(2022, 11, 11, 13, 0, 0)));
    Patient p9 = (Patient.constructor2(
        "Prerna Chandolia", "9876543256", "pChandolia@gmail.com","18","Female"));
    doc.addrequest(appointmentDetails.constructor(p9, doc,
        DateTime(2022, 11, 11, 10, 0, 0), DateTime(2022, 11, 11, 11, 0, 0)));
  }
}
