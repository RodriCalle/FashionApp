import 'package:demo_fashion_app/classes/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Guardar información del usuario logueado
Future<void> saveUserLoggedIn(Account account) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user_id', account.id);
  prefs.setString('user_name', account.names);
  prefs.setString('user_lastname', account.lastNames);
}

// Recuperar información del usuario logueado
Future<Account> getUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String userId = prefs.getString('user_id') ?? '';
  String? userName = prefs.getString('user_name') ?? '';
  String? userEmail = prefs.getString('user_email') ?? '';

  return Account(id: userId, names: userName, email: userEmail);
}

// Guardar la temperatura
Future<void> saveTemperature(String temperature) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('temperature', temperature);
}

// Recuperar la temperatura
Future<String> getTemperature() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String temperature = prefs.getString('temperature') ?? '22';
  return temperature;
}


