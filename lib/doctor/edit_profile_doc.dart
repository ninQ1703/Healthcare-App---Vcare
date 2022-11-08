import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../doctor/home_screen_doc.dart';
import '../main.dart';
import '../welcome.dart';
// import 'package:ooadproject/home_screen.dart';

class EditProfilePage_doc extends StatefulWidget {
  EditProfilePage_doc({super.key, required this.doc});
  Doctor doc;
  // const EditProfilePage({Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePage_docState createState() => _EditProfilePage_docState();
}

class _EditProfilePage_docState extends State<EditProfilePage_doc> {
  bool showPassword = false;
  CollectionReference users = FirebaseFirestore.instance.collection('Doctor');

  String sp = "", nm = "", educ = "";
  double ct = 0;
  @override
  Widget build(BuildContext context) {
    Doctor doc = widget.doc;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 240, 209),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("My Profile"),
        // Theme.of(context).scaffoldBackgroundColor,
        elevation: 3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(
            context,
            rootNavigator: true,
          ).pop(
            context,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              // const Text(
              //   "My Profile",
              //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              // ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage('assets/images/imgdefault.png'))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  onChanged: (value) {
                    nm = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      labelText: "Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // hintText: placeholder,
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      labelText: "Contact Number",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // hintText: placeholder,
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  onChanged: (value) {
                    ct = double.parse(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  onChanged: (value) {
                    sp = value;
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Specialisation",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // hintText: placeholder,
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (value) {
                    educ = value;
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Educational Details",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // hintText: placeholder,
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),

              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pop(
                        context,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            //  fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      //addUser();
                      // Call the user's CollectionReference to add a new user
                      return await users
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .update({
                            "Name": nm,
                            "Specialisation": sp,
                            "contact no": ct,
                            "Educational Details": educ,
                          })
                          .then((value) => print("Profile updated"))
                          .catchError(
                              (error) => print("Failed to update: $error"));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // foreground
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text("SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
