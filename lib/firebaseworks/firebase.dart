import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

String email;
SharedPreferences _prefs;
Future<void> sharedPrefs() async {
  _prefs = await SharedPreferences.getInstance();
  Future writeUser(String email, String password) async {
    await _prefs.setString("email", email);
    await _prefs.setString("password", password);
  }

  Future<String> readUser() async {
    email = await _prefs.getString("email");
    print("$email====---asdasldka;ksd");
    return email;
  }
}
