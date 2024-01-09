
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'CustomerDto.dart';
import 'PersistenceUtil.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  bool persoenlicheDatenAendern = false;
  bool emailAendern = false;
  bool passwortAendern = false;

  late String? vorname;
  late String? nachname;
  late String? strasse;
  late String? hausnummer;
  late String? plz;
  late String? stadt;

  late String selectedValue;
  final vornameTextController = TextEditingController();
  final nachnameTextController = TextEditingController();
  final strasseTextController = TextEditingController();
  final hausnummerTextController = TextEditingController();
  final plzTextController = TextEditingController();
  final stadtTextController = TextEditingController();

  late String? email;
  final emailTextController = TextEditingController();

  late String? passwort;
  final passwortTextController = TextEditingController();

  File? image;

  late CustomerDto? customerDTo;
  bool loadedData = false;

  bool updateDataSuccess = false;

  @override
  void initState() {
    super.initState();

    PersistenceUtil.getCustomer().then((value) => setState(() {
      print("init state");
      customerDTo=value;

      if(customerDTo!=null){

        vorname = customerDTo!.firstName != null ? customerDTo!.firstName : "";
        nachname = customerDTo!.lastName != null ? customerDTo!.lastName : "";
        strasse = customerDTo!.street!= null ? customerDTo!.street: "";
        hausnummer = customerDTo!.streetNumber != null ? customerDTo!.streetNumber: "";
        plz = customerDTo!.zip != null ? customerDTo!.zip : "";
        stadt = customerDTo!.city != null ? customerDTo!.city : "";

        vornameTextController.text = vorname!;
        nachnameTextController.text = nachname!;
        strasseTextController.text = strasse!;
        hausnummerTextController.text = hausnummer!;
        plzTextController.text = plz!;
        stadtTextController.text = stadt!;

        email = customerDTo!.email != null ? customerDTo!.email : "";
        emailTextController.text = email!;

        passwort = customerDTo!.password != null ? customerDTo!.password : "";
        passwortTextController.text = passwort!;

      }

      loadedData = true;

      // Update your UI with the desired changes.
    }));

  }

  @override
  Widget build(BuildContext context) {
    print("build");

    if(loadedData){

      return SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // The containers in the background
              (MediaQuery.of(context).orientation == Orientation.landscape)
                  ? Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .90,
                padding: EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 40),
                color: Colors.pink[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: image != null
                            ? Image.file(
                          image!,
                          fit: BoxFit.cover,
                          width: 220,
                          height: 220,
                        )
                            : Image.asset(
                          "lib/images/profilbild.jpg",
                          fit: BoxFit.cover,
                          width: 220,
                          height: 220,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 10, right: 20),
                          child: GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: Container(
                                color: Colors.grey,
                                child: Row(
                                  children: [
                                    Icon(Icons.edit_outlined),
                                    Icon(Icons.image_outlined),
                                  ],
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              pickImageC();
                            },
                            child: Container(
                                color: Colors.grey,
                                child: Row(
                                  children: [
                                    Icon(Icons.edit_outlined),
                                    Icon(Icons.camera_alt_outlined),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  : Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * .50,
                padding: EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 40),
                color: Colors.pink[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: image != null
                            ? Image.file(
                          image!,
                          fit: BoxFit.cover,
                          width: 240,
                          height: 240,
                        )
                            : Image.asset(
                          "lib/images/profilbild.jpg",
                          fit: BoxFit.cover,
                          width: 240,
                          height: 240,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 10, right: 20),
                          child: GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: Container(
                                color: Colors.grey,
                                child: Row(
                                  children: [
                                    Icon(Icons.edit_outlined),
                                    Icon(Icons.image_outlined),
                                  ],
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              pickImageC();
                            },
                            child: Container(
                                color: Colors.grey,
                                child: Row(
                                  children: [
                                    Icon(Icons.edit_outlined),
                                    Icon(Icons.camera_alt_outlined),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // The card widget with top padding,
              // incase if you wanted bottom padding to work,
              // set the `alignment` of container to Alignment.bottomCenter
              Container(
                //color: Colors.brown,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).orientation ==
                        Orientation.landscape)
                        ? MediaQuery.of(context).size.height * .80
                        : MediaQuery.of(context).size.height * .45,
                    right: 5.0,
                    left: 5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF7B1A33),
                  margin: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 10),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 5),
                    child: Column(
                      children: [
                        persoenlicheDatenAendern
                            ? Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.only(bottom: 15),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20, bottom: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Persönliche Daten',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 12,
                                        ),

                                        Row(
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.32
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.2,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  "Vorname:",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.48
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.6,
                                              height: 30,
                                              child: TextField(
                                                controller:
                                                vornameTextController,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal),
                                                textAlignVertical:
                                                TextAlignVertical.center,
                                                maxLength: 25,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.only(),
                                                  filled: true,
                                                  fillColor: Colors.grey[100],
                                                  counterText: "",
                                                  focusedBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  hintText: "Vorname...",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.32
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.2,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  "Nachname:",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.48
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.6,
                                              height: 30,
                                              child: TextField(
                                                controller:
                                                nachnameTextController,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal),
                                                textAlignVertical:
                                                TextAlignVertical.center,
                                                maxLength: 25,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.only(),
                                                  filled: true,
                                                  fillColor: Colors.grey[100],
                                                  counterText: "",
                                                  focusedBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  hintText: "Nachname...",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.32
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.2,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  "Straße:",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.48
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.6,
                                              height: 30,
                                              child: TextField(
                                                controller:
                                                strasseTextController,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal),
                                                textAlignVertical:
                                                TextAlignVertical.center,
                                                maxLength: 25,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.only(),
                                                  filled: true,
                                                  fillColor: Colors.grey[100],
                                                  counterText: "",
                                                  focusedBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  hintText: "Straße...",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.32
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.2,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  "Hausnummer:",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.48
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.6,
                                              height: 30,
                                              child: TextField(
                                                controller:
                                                hausnummerTextController,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal),
                                                textAlignVertical:
                                                TextAlignVertical.center,
                                                maxLength: 25,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.only(),
                                                  filled: true,
                                                  fillColor: Colors.grey[100],
                                                  counterText: "",
                                                  focusedBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  hintText: "Hausnummer...",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.32
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.2,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  "Postleitzahl:",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.48
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.6,
                                              height: 30,
                                              child: TextField(
                                                controller: plzTextController,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal),
                                                textAlignVertical:
                                                TextAlignVertical.center,
                                                maxLength: 25,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.only(),
                                                  filled: true,
                                                  fillColor: Colors.grey[100],
                                                  counterText: "",
                                                  focusedBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  hintText: "Postleitzahl...",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.32
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.2,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  "Stadt:",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.48
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.6,
                                              height: 30,
                                              child: TextField(
                                                controller:
                                                stadtTextController,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal),
                                                textAlignVertical:
                                                TextAlignVertical.center,
                                                maxLength: 25,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.only(),
                                                  filled: true,
                                                  fillColor: Colors.grey[100],
                                                  counterText: "",
                                                  focusedBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  hintText: "Stadt...",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.grey),
                                                foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                                overlayColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                  states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return Colors
                                                          .greenAccent; // Change this to desired press color
                                                    }
                                                    return Colors
                                                        .greenAccent; // Change this to desired press color
                                                  },
                                                ),
                                                shape:
                                                MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    side: BorderSide(
                                                        color: Color(
                                                            0xFF222222)), // Border color and width
                                                  ),
                                                ),
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsets>(
                                                    EdgeInsets.all(5)),
                                                textStyle:
                                                MaterialStateProperty.all<
                                                    TextStyle>(
                                                  TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                // Flutter doesn't support transitions for state changes; you'd use animations for that.
                                              ),
                                              onPressed: () async {

                                                customerDTo!.firstName = vornameTextController.text;
                                                customerDTo!.lastName = nachnameTextController.text;
                                                customerDTo!.street = strasseTextController.text;
                                                customerDTo!.streetNumber = hausnummerTextController.text;
                                                customerDTo!.zip = plzTextController.text;
                                                customerDTo!.city = stadtTextController.text;

                                                //await updateCustomerData(customerDTo!);
                                                await PersistenceUtil.setCustomer(customerDTo!);

                                                // if (updateDataSuccess){

                                                  vorname =
                                                      vornameTextController
                                                          .text;
                                                  nachname =
                                                      nachnameTextController
                                                          .text;
                                                  strasse =
                                                      strasseTextController
                                                          .text;
                                                  hausnummer =
                                                      hausnummerTextController
                                                          .text;
                                                  plz = plzTextController
                                                      .text;
                                                  stadt =
                                                      stadtTextController
                                                          .text;

                                                //  await PersistenceUtil.setCustomer(customerDTo!);

                                                  setState(() {

                                                    persoenlicheDatenAendern =
                                                    false;

                                                  });

                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(

                                                    content:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
                                                          child: Icon(color: Colors.greenAccent, size: 30, Icons.info_outlined),
                                                        ),
                                                        Expanded(
                                                          child:

                                                          Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text("Daten wurden erfolgreich aktualisiert!",
                                                              textAlign: TextAlign.center,
                                                              softWrap: true,
                                                              style: const TextStyle(
                                                                height: 0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.greenAccent,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                  ));


                                                // }
                                                // else{
                                                //
                                                //   setState(() {
                                                //
                                                //     customerDTo!.firstName = vorname;
                                                //     customerDTo!.lastName = nachname;
                                                //     customerDTo!.street = strasse;
                                                //     customerDTo!.streetNumber = hausnummer;
                                                //     customerDTo!.zip = plz;
                                                //     customerDTo!.city = stadt;
                                                //
                                                //     vornameTextController.text =
                                                //     vorname!;
                                                //     nachnameTextController
                                                //         .text = nachname!;
                                                //     strasseTextController.text =
                                                //     strasse!;
                                                //     hausnummerTextController
                                                //         .text = hausnummer!;
                                                //     plzTextController.text =
                                                //     plz!;
                                                //     stadtTextController.text =
                                                //     stadt!;
                                                //
                                                //     persoenlicheDatenAendern =
                                                //     false;
                                                //
                                                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                //
                                                //       content:
                                                //       Row(
                                                //         mainAxisAlignment: MainAxisAlignment.center,
                                                //         mainAxisSize: MainAxisSize.max,
                                                //         crossAxisAlignment: CrossAxisAlignment.center,
                                                //         children: [
                                                //           const Padding(
                                                //             padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
                                                //             child: Icon(color: Colors.orange, size: 30, Icons.warning_outlined),
                                                //           ),
                                                //           Expanded(
                                                //             child:
                                                //
                                                //             Align(
                                                //               alignment: Alignment.centerLeft,
                                                //               child: Text(FlavorSettings.getFlavorSettings().style!.getDatenNichtAktualisiert(),
                                                //
                                                //                 softWrap: true,
                                                //                 style: const TextStyle(
                                                //                   height: 0,
                                                //                   fontWeight: FontWeight.bold,
                                                //                   color: Colors.orange,
                                                //                   fontSize: 16,
                                                //                 ),
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //
                                                //       //Text("Daten konnten nicht aktualisiert werden!"),
                                                //     ));
                                                //
                                                //   });
                                                //
                                                // }

                                              },
                                              label: Text('Speichern'),
                                              icon: Icon(Icons.save),
                                            ),
                                            ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.grey),
                                                foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                                overlayColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                  states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return Colors
                                                          .redAccent; // Change this to desired press color
                                                    }
                                                    return Colors
                                                        .redAccent; // Change this to desired press color
                                                  },
                                                ),
                                                shape:
                                                MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    side: BorderSide(
                                                        color: Color(
                                                            0xFF222222)), // Border color and width
                                                  ),
                                                ),
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsets>(
                                                    EdgeInsets.all(5)),
                                                textStyle:
                                                MaterialStateProperty.all<
                                                    TextStyle>(
                                                  TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                // Flutter doesn't support transitions for state changes; you'd use animations for that.
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  vornameTextController.text =
                                                  vorname!;
                                                  nachnameTextController
                                                      .text = nachname!;
                                                  strasseTextController.text =
                                                  strasse!;
                                                  hausnummerTextController
                                                      .text = hausnummer!;
                                                  plzTextController.text =
                                                  plz!;
                                                  stadtTextController.text =
                                                  stadt!;

                                                  persoenlicheDatenAendern =
                                                  false;
                                                });
                                              },
                                              label: Text('Abbrechen'),
                                              icon:
                                              Icon(Icons.cancel_outlined),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                            : Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.only(bottom: 15),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 10, top: 20, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Persönliche Daten',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),

                                      Text(
                                        vorname! + " " + nachname!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        strasse! + " " + hausnummer!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        plz! + " " + stadt!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: 15,
                                        top: 20,
                                        bottom: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        print(
                                            "Persönliche Daten ändern geklickt!");

                                        setState(() {
                                          persoenlicheDatenAendern = true;
                                        });
                                      },
                                      child: Icon(
                                          color: Colors.grey,
                                          size: 30,
                                          Icons.edit_outlined),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        emailAendern
                            ? Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.only(bottom: 15),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20, bottom: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'E-Mail-Adresse',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.18
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.12,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  "E-Mail:",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.62
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.68,
                                              height: 30,
                                              child: TextField(
                                                controller:
                                                emailTextController,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.normal),
                                                textAlignVertical:
                                                TextAlignVertical.center,
                                                maxLength: 25,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.only(),
                                                  filled: true,
                                                  fillColor: Colors.grey[100],
                                                  counterText: "",
                                                  focusedBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  hintText: "E-Mail...",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.grey),
                                                foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                                overlayColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                  states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return Colors
                                                          .greenAccent; // Change this to desired press color
                                                    }
                                                    return Colors
                                                        .greenAccent; // Change this to desired press color
                                                  },
                                                ),
                                                shape:
                                                MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    side: BorderSide(
                                                        color: Color(
                                                            0xFF222222)), // Border color and width
                                                  ),
                                                ),
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsets>(
                                                    EdgeInsets.all(5)),
                                                textStyle:
                                                MaterialStateProperty.all<
                                                    TextStyle>(
                                                  TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                // Flutter doesn't support transitions for state changes; you'd use animations for that.
                                              ),
                                              onPressed: () async {

                                                customerDTo!.email= emailTextController.text;

                                                //await updateCustomerData(customerDTo!);
                                                await PersistenceUtil.setCustomer(customerDTo!);

                                                // if (updateDataSuccess){

                                                  email =
                                                      emailTextController
                                                          .text;


                                                  // await PersistenceUtil.setCustomer(customerDTo!);

                                                  setState(() {

                                                    emailAendern =
                                                    false;

                                                  });

                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(

                                                    content:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
                                                          child: Icon(color: Colors.greenAccent, size: 30, Icons.info_outlined),
                                                        ),
                                                        Expanded(
                                                          child:

                                                          Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text("Daten wurden erfolgreich aktualisiert!",
                                                              textAlign: TextAlign.center,
                                                              softWrap: true,
                                                              style: const TextStyle(
                                                                height: 0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.greenAccent,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                  ));


                                                // }
                                                // else{
                                                //
                                                //   setState(() {
                                                //
                                                //     customerDTo!.email = email;
                                                //
                                                //     emailTextController.text =
                                                //     email!;
                                                //
                                                //
                                                //     emailAendern =
                                                //     false;
                                                //
                                                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                //
                                                //       content:
                                                //       Row(
                                                //         mainAxisAlignment: MainAxisAlignment.center,
                                                //         mainAxisSize: MainAxisSize.max,
                                                //         crossAxisAlignment: CrossAxisAlignment.center,
                                                //         children: [
                                                //           const Padding(
                                                //             padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
                                                //             child: Icon(color: Colors.orange, size: 30, Icons.warning_outlined),
                                                //           ),
                                                //           Expanded(
                                                //             child:
                                                //
                                                //             Align(
                                                //               alignment: Alignment.centerLeft,
                                                //               child: Text(FlavorSettings.getFlavorSettings().style!.getDatenNichtAktualisiert(),
                                                //
                                                //                 softWrap: true,
                                                //                 style: const TextStyle(
                                                //                   height: 0,
                                                //                   fontWeight: FontWeight.bold,
                                                //                   color: Colors.orange,
                                                //                   fontSize: 16,
                                                //                 ),
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //
                                                //       //Text("Daten konnten nicht aktualisiert werden!"),
                                                //     ));
                                                //
                                                //   });
                                                //
                                                // }

                                              },
                                              label: Text('Speichern'),
                                              icon: Icon(Icons.save),
                                            ),
                                            ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.grey),
                                                foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                                overlayColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                  states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return Colors
                                                          .redAccent; // Change this to desired press color
                                                    }
                                                    return Colors
                                                        .redAccent; // Change this to desired press color
                                                  },
                                                ),
                                                shape:
                                                MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    side: BorderSide(
                                                        color: Color(
                                                            0xFF222222)), // Border color and width
                                                  ),
                                                ),
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsets>(
                                                    EdgeInsets.all(5)),
                                                textStyle:
                                                MaterialStateProperty.all<
                                                    TextStyle>(
                                                  TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                // Flutter doesn't support transitions for state changes; you'd use animations for that.
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  emailTextController.text =
                                                  email!;
                                                  emailAendern = false;
                                                });
                                              },
                                              label: Text('Abbrechen'),
                                              icon:
                                              Icon(Icons.cancel_outlined),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                            : Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.only(bottom: 15),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 10, top: 20, bottom: 25),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'E-Mail-Adresse',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        email!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: 15,
                                        top: 20,
                                        bottom: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("Email ändern geklickt!");

                                        setState(() {
                                          emailAendern = true;
                                        });
                                      },
                                      child: Icon(
                                          color: Colors.grey,
                                          size: 30,
                                          Icons.edit_outlined),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        passwortAendern
                            ? Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.only(bottom: 15),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20, bottom: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Passwort',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.25
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.15,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  "Passwort:",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                  .orientation ==
                                                  Orientation.portrait)
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  .55
                                                  : MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  .65,
                                              height: 30,
                                              child: TextField(
                                                controller:
                                                passwortTextController,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.normal),
                                                textAlignVertical:
                                                TextAlignVertical.center,
                                                maxLength: 25,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.only(),
                                                  filled: true,
                                                  fillColor: Colors.grey[100],
                                                  counterText: "",
                                                  focusedBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                  const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            0.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                        width: 0.0),
                                                  ),
                                                  hintText: "Passwort...",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.grey),
                                                foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                                overlayColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                  states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return Colors
                                                          .greenAccent; // Change this to desired press color
                                                    }
                                                    return Colors
                                                        .greenAccent; // Change this to desired press color
                                                  },
                                                ),
                                                shape:
                                                MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    side: BorderSide(
                                                        color: Color(
                                                            0xFF222222)), // Border color and width
                                                  ),
                                                ),
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsets>(
                                                    EdgeInsets.all(5)),
                                                textStyle:
                                                MaterialStateProperty.all<
                                                    TextStyle>(
                                                  TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                // Flutter doesn't support transitions for state changes; you'd use animations for that.
                                              ),
                                              onPressed: () async {

                                                customerDTo!.password = passwortTextController.text;

                                                //await updateCustomerData(customerDTo!);
                                                await PersistenceUtil.setCustomer(customerDTo!);

                                                // if (updateDataSuccess){

                                                  passwort =
                                                      passwortTextController
                                                          .text;


                                                  // await PersistenceUtil.setCustomer(customerDTo!);

                                                  setState(() {

                                                    passwortAendern =
                                                    false;

                                                  });

                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(

                                                    content:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
                                                          child: Icon(color: Colors.greenAccent, size: 30, Icons.info_outlined),
                                                        ),
                                                        Expanded(
                                                          child:

                                                          Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text("Daten wurden erfolgreich aktualisiert!",
                                                              textAlign: TextAlign.center,
                                                              softWrap: true,
                                                              style: const TextStyle(
                                                                height: 0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.greenAccent,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                  ));


                                                // }
                                                // else{
                                                //
                                                //   setState(() {
                                                //
                                                //     customerDTo!.password = passwort;
                                                //
                                                //
                                                //     passwortTextController.text =
                                                //     passwort!;
                                                //
                                                //
                                                //     persoenlicheDatenAendern =
                                                //     false;
                                                //
                                                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                //
                                                //       content:
                                                //       Row(
                                                //         mainAxisAlignment: MainAxisAlignment.center,
                                                //         mainAxisSize: MainAxisSize.max,
                                                //         crossAxisAlignment: CrossAxisAlignment.center,
                                                //         children: [
                                                //           const Padding(
                                                //             padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
                                                //             child: Icon(color: Colors.orange, size: 30, Icons.warning_outlined),
                                                //           ),
                                                //           Expanded(
                                                //             child:
                                                //
                                                //             Align(
                                                //               alignment: Alignment.centerLeft,
                                                //               child: Text(FlavorSettings.getFlavorSettings().style!.getDatenNichtAktualisiert(),
                                                //
                                                //                 softWrap: true,
                                                //                 style: const TextStyle(
                                                //                   height: 0,
                                                //                   fontWeight: FontWeight.bold,
                                                //                   color: Colors.orange,
                                                //                   fontSize: 16,
                                                //                 ),
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //
                                                //       //Text("Daten konnten nicht aktualisiert werden!"),
                                                //     ));
                                                //
                                                //   });
                                                //
                                                // }

                                              },
                                              label: Text('Speichern'),
                                              icon: Icon(Icons.save),
                                            ),
                                            ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.grey),
                                                foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                                overlayColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                  states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return Colors
                                                          .redAccent; // Change this to desired press color
                                                    }
                                                    return Colors
                                                        .redAccent; // Change this to desired press color
                                                  },
                                                ),
                                                shape:
                                                MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    side: BorderSide(
                                                        color: Color(
                                                            0xFF222222)), // Border color and width
                                                  ),
                                                ),
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsets>(
                                                    EdgeInsets.all(5)),
                                                textStyle:
                                                MaterialStateProperty.all<
                                                    TextStyle>(
                                                  TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                // Flutter doesn't support transitions for state changes; you'd use animations for that.
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  passwortTextController
                                                      .text = passwort!;
                                                  passwortAendern = false;
                                                });
                                              },
                                              label: Text('Abbrechen'),
                                              icon:
                                              Icon(Icons.cancel_outlined),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                            : Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.only(bottom: 15),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 10, top: 20, bottom: 25),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Passwort',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        passwort!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: 15,
                                        top: 20,
                                        bottom: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("Passwort ändern geklickt!");

                                        setState(() {
                                          passwortAendern = true;
                                        });
                                      },
                                      child: Icon(
                                          color: Colors.grey,
                                          size: 30,
                                          Icons.edit_outlined),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

    }
    else{
      return Container();
    }

  }

  // updateCustomerData(CustomerDto customerDto) async{
  //   LiveApiRequest<CustomerDto> liveApiRequest = LiveApiRequest<CustomerDto>(path: "/customer/update");
  //   ApiResponse apiResponse = await liveApiRequest.executePost(customerDto);
  //   if(apiResponse.status == Status.SUCCESS){
  //     //...
  //     updateDataSuccess = true;
  //
  //
  //   }else{
  //
  //     updateDataSuccess = false;
  //     //...
  //   }
  // }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
