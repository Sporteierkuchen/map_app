
import 'package:flutter/material.dart';
import 'package:map_app/CustomerDto.dart';
import 'BottomNavigationBar.dart';
import 'PersistenceUtil.dart';
import 'RegistrationPage.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    loadMain(context);
    return Container(
      //TODO splash screen image
    );
  }

  void loadMain(BuildContext context) async {

    CustomerDto? custDTO = await PersistenceUtil.getCustomer();

      if (custDTO == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RegistrationPage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()));
      }

  }
}