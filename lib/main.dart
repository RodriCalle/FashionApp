import 'package:demo_fashion_app/components/ScaffoldComponent.dart';
import 'package:demo_fashion_app/views/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:huawei_ml_image/huawei_ml_image.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await MLImageApplication().setApiKey("DAEDANXOVlW+my3N+0nlg27MELZvS7q7CAx7YKUVPNBlUawu9gr6Uzq7Ml9GCt1jqsbQKHyEI8fD0rm00HH8Uu1b3uasckZ7jJeHvg==");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion App',
      debugShowCheckedModeBanner: false,
    /*  home: const ScaffoldComponent(),*/
      home: LoginPage(),
    );
  }
}
