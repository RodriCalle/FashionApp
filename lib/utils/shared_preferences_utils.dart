import 'package:demo_fashion_app/classes/Auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Guardar información del usuario logueado
Future<void> saveUserLoggedIn(Account account) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user_id', account.id);
  prefs.setString('user_name', account.names);
  prefs.setString('user_lastname', account.lastNames);
  prefs.setString('user_email', account.email);
  prefs.setString('user_sex', account.sex);
}

// Recuperar información del usuario logueado
Future<Account?> getUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? userId = prefs.getString('user_id');
  String? userName = prefs.getString('user_name');
  String? userEmail = prefs.getString('user_email');

  if (userId != null && userName != null && userEmail != null) {
    return Account(id: userId, names: userName, email: userEmail);
  } else {
    return null;
  }
}


