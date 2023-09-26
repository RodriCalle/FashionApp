import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

Future<void> requestLocationPermission() async {
  const platform =
      const MethodChannel('com.example.demo_fashion_app/permissions');

  try {
    await platform.invokeMethod('requestLocationPermission');
  } on PlatformException catch (e) {
    print("Error: $e");
  }
}

class TemperatureService {
  final String apiKey = "e1f3c9025bee415680fe2116212424c7";
  String baseUrl = "https://api.weatherbit.io/v2.0/current?lang=es";

  String temp = "0";

  Future<String> getTemperature() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      await getTemperature();
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final Uri uri = Uri.parse(
          '$baseUrl&lat=${position.latitude.toString()}&lon=${position.longitude.toString()}&key=$apiKey');
      print(uri.toString());
      try {
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final temperature = jsonData['data'][0]['temp'];

          temp = temperature.toString();
        } else {
          //throw Exception('Failed to load temperature data');
          temp = "0";
        }
      } catch (e) {
        throw Exception('Error: $e');
      }
    }
    return temp;
  }
}
