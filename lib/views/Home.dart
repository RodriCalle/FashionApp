

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
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
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 200,
                    child: Text("Bienvenido, Rodrigo, la temperatura de hoy es de 26°"),
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text("¿que te vas a poner?", textAlign: TextAlign.start),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 80,
                    width: 2,
                    color: Colors.black,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(Icons.sunny, size: 50,),
                ],
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: MaterialButton(
                    color: Colors.blue,
                    child: const Text("Pick Image from Gallery",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      pickImageFromGallery();
                    }),
              ),
              Container(
                child: MaterialButton(
                    color: Colors.blue,
                    child: const Text("Pick Image from Camera",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      pickImageFromCamera();
                    }),
              ),
              Container(
                child: image == null
                    ? const Text('No image selected.')
                    : Image.file(image!, width: 200, height: 200),
              )
            ],
          ),
        ],
      ),
    );
  }
}
