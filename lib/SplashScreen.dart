
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BottomNavigationBar.dart';
import 'LoginPage.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    loadMain(context);
    return Container(
        //TODO splash screen image
        );
  }

  void loadMain(BuildContext context) async {

    bool start=true;
      if (start== false) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()));
      }

  }
}
