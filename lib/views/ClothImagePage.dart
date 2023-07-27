import 'dart:io';

import 'package:flutter/material.dart';

class ClothImagePage extends StatefulWidget {
  final File? image;

  const ClothImagePage({Key? key, this.image}) : super(key: key);

  @override
  State<ClothImagePage> createState() => _ClothImagePageState();
}

class _ClothImagePageState extends State<ClothImagePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double bodyHeight = constraints.maxHeight;
      double bodyWidth = constraints.maxWidth;

      return Row(
        children: [
          Container(
              width: bodyWidth,
              height: bodyHeight * 0.7,
              /*decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),*/
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        this.widget.image == null
                            ? Image.asset(
                                "assets/images/placeholder.jpg",
                                width: bodyWidth * 0.6,
                              )
                            : Image.file(this.widget.image!)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: bodyWidth * 0.6,
                          child: MaterialButton(
                              color: Color.fromRGBO(249,235,219, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide.none
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                    "Mejorar Imagen",
                                    style: TextStyle(
                                        color: Colors.black, fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    )
                                ),
                              ),
                              onPressed: () {
                                improveImage();
                              }),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ],
      );
    });
  }

  void improveImage() {}
}
