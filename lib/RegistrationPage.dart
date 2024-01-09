import 'dart:convert';
import 'package:flutter/material.dart';

import 'BottomNavigationBar.dart';
import 'CustomerDto.dart';
import 'LoginPage.dart';
import 'TextInput.dart';
import 'WrapperPageState.dart';
import 'PersistenceUtil.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationpageState();
  }
}

class RegistrationpageState extends WrapperPageState<RegistrationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget getContent() {
    return 
      
      SingleChildScrollView(
        child: Column(
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                "Konto erstellen",
                style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xFF2F1155),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextInput(
                label: "Email",
                obscureText: false,
                controller: emailController,
                icon: const Icon(Icons.email),
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextInput(
                label: "Vorname",
                obscureText: false,
                controller: firstnameController,
                icon: const Icon(Icons.person),
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextInput(
                label: "Nachname",
                obscureText: false,
                controller: lastnameController,
                icon: const Icon(Icons.person),
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextInput(
                label: "Passwort",
                obscureText: true,
                controller: passwordController,
                icon: const Icon(Icons.key),
              )),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {register();},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: const Color(0xFF5B259F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Konto erstellen"),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text("Haben Sie ein Konto?")),
          Container(
              margin: const EdgeInsets.only(top: 5),
              child: InkWell(
                child: Text(
                  "Anmelden",
                  style: const TextStyle(color: Color(0xFF0000FF)),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ))
        ],
        ),
      );
  }

  register() async {

    if(firstnameController.text.trim().isNotEmpty && lastnameController.text.trim().isNotEmpty && emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {

      CustomerDto customerDto = CustomerDto(firstName: firstnameController.text, lastName: lastnameController.text, email: emailController.text, password: passwordController.text);

      await PersistenceUtil.setCustomer(customerDto);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Success"),
      ));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error"),
      ));
    }

  }
}


