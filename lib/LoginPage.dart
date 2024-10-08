import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:map_app/CustomerDto.dart';
import 'package:map_app/PersistenceUtil.dart';

import 'BottomNavigationBar.dart';
import 'RegistrationPage.dart';
import 'TextInput.dart';
import 'WrapperPageState.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends WrapperPageState<LoginPage> {
  TextEditingController emailController = TextEditingController();
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
                "Sie haben bereits ein Konto? Melden Sie sich jetzt an",
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
                label: "Passwort",
                obscureText: true,
                controller: passwordController,
                icon: const Icon(Icons.key),
              )),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {login();},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: const Color(0xFF5B259F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Anmelden"),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text("Haben Sie doch kein Konto?")),
          Container(
              margin: const EdgeInsets.only(top: 5),
              child: InkWell(
                child: Text(
                  "Zurück",
                  style: const TextStyle(color: Color(0xFF0000FF)),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()));
                },
              ))
        ],
    ),
      );
  }

  login() async {

    CustomerDto? custDTO = await PersistenceUtil.getCustomer();

    if(custDTO != null){

      if(custDTO.email?.compareTo(emailController.text.trim()) == 0 && custDTO.password?.compareTo(passwordController.text.trim()) == 0 ){

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Success"),
        ));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()));

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error"),
        ));

      }

    }
    else{

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No CustomerDTO"),
      ));

    }

  }

}

