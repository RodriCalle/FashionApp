
import 'package:demo_fashion_app/views/LoginPage.dart';
import 'package:flutter/material.dart';

import 'components/ScaffoldComponent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion App',
      debugShowCheckedModeBanner: false,
      home: ScaffoldComponent(),
    );
  }
}