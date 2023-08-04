import 'dart:io';

import 'package:demo_fashion_app/styles/ColorStyles.dart';
import 'package:flutter/material.dart';

class GenerateOutfitsPage extends StatefulWidget {
  final File? image;
  final ValueChanged<int> onSubStepChanged;

  const GenerateOutfitsPage(
      {Key? key, this.image, required this.onSubStepChanged})
      : super(key: key);

  @override
  State<GenerateOutfitsPage> createState() => _GenerateOutfitsPageState();
}

class _GenerateOutfitsPageState extends State<GenerateOutfitsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double bodyHeight = constraints.maxHeight;
      double bodyWidth = constraints.maxWidth;

      return Row(
        children: [
          Container(
              width: bodyWidth,
              height: bodyHeight,
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
                              color: Color.fromRGBO(249, 235, 219, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide.none),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("Generar Conjuntos",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                              onPressed: () {
                                generateOutfits();
                              }),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: grey,
                                border: Border.all(
                                  color: grey,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(20),
                            width: bodyWidth * 0.6,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Características",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Tipo: Polo Cuello Camisa"),
                                Text("Color: negro"),
                                Text("Material: Algodón"),
                                Text("Estilo: Casual"),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              )),
        ],
      );
    });
  }

  void generateOutfits() {
    widget.onSubStepChanged(3);
  }
}
