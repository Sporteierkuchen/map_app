

import 'package:flutter/material.dart';

import 'WrapperPageState.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends WrapperPageState<LoginPage> {
  @override
  Widget getContent() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
            alignment: Alignment.center,
            width: double.infinity,
            child: const Text(
              "test",
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF2F1155),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
        Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextInput(
                label: "test",
                obscureText: false,
                controller: TextEditingController(),
                icon: const Icon(Icons.person))),
        Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextInput(
              label: "test",
              obscureText: false,
              controller: TextEditingController(),
              icon: const Icon(Icons.email),
            )),
        Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextInput(
              label: "test",
              obscureText: true,
              controller: TextEditingController(),
              icon: const Icon(Icons.key),
            )),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: const Color(0xFF5B259F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("test"),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 20),

        child: Container(
            margin: const EdgeInsets.only(top: 5),
            child: InkWell(
              child: const Text(
                "test",
                style: TextStyle(color: Color(0xFF0000FF)),
              ),
              onTap: () {},
            ))),
      ],
    );
  }
}

class TextInput extends TextFormField {
  TextInput(
      {required String label,
      required bool obscureText,
      required TextEditingController controller,
      required Icon icon})
      : super(
            controller: controller,
            cursorColor: const Color(0xFF000000),
            decoration: InputDecoration(
              prefixIcon: icon,
              labelText: label,
              labelStyle: const TextStyle(color: Color(0xFF999999)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFDDDDDD))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF000000))),
              prefixIconColor: const Color(0xFF999999),
              filled: true,
              fillColor: const Color(0xFFDDDDDD),
            ),
            obscureText: obscureText);
}
