import 'dart:io';

import 'package:demo_fashion_app/classes/Auth.dart';
import 'package:demo_fashion_app/services/FirebaseService.dart';
import 'package:demo_fashion_app/utils/image_utils.dart.dart';
import 'package:demo_fashion_app/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int> onSubStepChanged;

  const HomePage({Key? key, required this.onSubStepChanged}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  Account loggedInUser = Account();

  @override
  void initState() {
    super.initState();
    image = null;
    _loadLoggedInUser();
  }

  void _loadLoggedInUser() async {
    final user = await FirebaseService().getUserInfo();
    setState(() {
      loggedInUser = user;
    });
    print(loggedInUser.names);
  }


  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);

      processImageWithESRGAN(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);

      processImageWithESRGAN(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    // widget.onSubStepChanged(1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double bodyHeight = constraints.maxHeight;
      double bodyWidth = constraints.maxWidth;

      return Center(
        child: Column(
          children: [
            Container(
              height: bodyHeight * 0.5,
              /*decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),*/
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Bienvenido",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              loggedInUser.names + ",",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "la temperatura de hoy es de 26°",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: const Text(
                          "¿que te vas a poner?",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: bodyHeight * 0.25,
                    width: 2,
                    color: Colors.black,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  Icon(
                    Icons.sunny,
                    size: 60,
                  ),
                ],
              ),
            ),
            Container(
              height: bodyHeight * 0.5,
              width: bodyWidth,
              /*decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),*/
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: bodyWidth * 0.6,
                    child: MaterialButton(
                        color: Color.fromRGBO(249, 235, 219, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide.none),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("Galería",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                        onPressed: () {
                          pickImageFromGallery();
                        }),
                  ),
                  Container(
                    width: bodyWidth * 0.6,
                    child: MaterialButton(
                        color: Color.fromRGBO(249, 235, 219, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide.none),
                        child: const Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Cámara",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                        onPressed: () {
                          pickImageFromCamera();
                        }),
                  ),
                  /*Container(
                    child: image == null
                        ? const Text('No image selected.')
                        : Image.file(image!, width: 200, height: 200),
                  )*/
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}


