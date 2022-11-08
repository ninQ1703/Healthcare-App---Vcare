import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../welcome.dart';

class MyRequests extends StatefulWidget {
  MyRequests({Key? key, required this.doc}) : super(key: key);
  Doctor doc;
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  DateFormat dateDisplay = DateFormat("MMMM dd, yyyy");
  DateFormat timeDisplay = DateFormat("hh : mm  a");

  @override
  Widget build(BuildContext context) {
    Doctor doc = widget.doc;

    return Scaffold(
        appBar: AppBar(
          title: Text("Appointment Requests"),
        ),
        body: ListView.builder(
          itemCount: (doc.requestlist.length),
          itemBuilder: (BuildContext, i) {
            return Card(
              child: ListTile(
                title: Text(dateDisplay.format(doc.requestlist[i].startTime) +
                    "   " +
                    timeDisplay.format(doc.requestlist[i].startTime)),
                subtitle: Text(doc.requestlist[i].patient.name),
                trailing: Column(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            doc.requestlist[i].setStatus(1);
                            doc.acceptRequest(doc.requestlist[i]);
                          });
                        },
                        child: const Text('Accept'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // background
                          onPrimary: Colors.white, // foreground
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            doc.requestlist[i].setStatus(3);
                            doc.declineRequest(doc.requestlist[i]);
                          });
                        },
                        child: const Text('Decline'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          shrinkWrap: true,
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ));
  }
}
