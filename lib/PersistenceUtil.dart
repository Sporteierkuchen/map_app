import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'CustomerDto.dart';

class PersistenceUtil {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //return "388ac4ef-c958-401c-8e9b-4a215cb3f3c5";
    return prefs.getString("token");
  }

  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future<String?> getSecret() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //return "5fc7ae68-390b-410f-a420-6839d2dfc1ca";
    return prefs.getString("secret");
  }

  static Future<void> setSecret(String secret) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("secret", secret);
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<CustomerDto?> getCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cDTO=prefs.getString("customerDTO");

    if(cDTO==null){
      return null;
    }
    return CustomerDto.fromJson(jsonDecode(cDTO));
  }

  static Future<void> setCustomer(CustomerDto customerDTO) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("customerDTO", jsonEncode(customerDTO.toJson()) );
  }

}
