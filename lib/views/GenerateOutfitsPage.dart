import 'dart:io';

import 'package:demo_fashion_app/classes/ClothInfoDetail.dart';
import 'package:demo_fashion_app/styles/ColorStyles.dart';
import 'package:flutter/material.dart';

class GenerateOutfitsPage extends StatefulWidget {
  final File? image;
  final ValueChanged<int> onSubStepChanged;
  final ValueChanged<File> onImageSelected;
  final ClothInfoDetail? clothInfoDetail;

  GenerateOutfitsPage(
      {Key? key, this.image, required this.onSubStepChanged, required this.onImageSelected, this.clothInfoDetail})
      : super(key: key);

  @override
  State<GenerateOutfitsPage> createState() => _GenerateOutfitsPageState();
}

class _GenerateOutfitsPageState extends State<GenerateOutfitsPage> {

  @override
  void initState() {
    super.initState();
  }

  void generateOutfits() async {
    widget.onSubStepChanged(3);
  }

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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 300,
                          width: 300,
                          child: widget.image == null
                              ? Image.asset(
                            "assets/images/placeholder.jpg",
                            width: bodyWidth * 0.6,
                          )
                              : Image.file(
                              this.widget.image!,
                              fit: BoxFit.contain
                          ),
                        )
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Características",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Tipo: ${widget.clothInfoDetail == null ? "No se pudo detectar" : widget.clothInfoDetail?.type}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "Color: ${widget.clothInfoDetail == null ? "No se pudo detectar" : widget.clothInfoDetail?.color}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "Material: ${widget.clothInfoDetail == null ? "No se pudo detectar" : widget.clothInfoDetail?.material}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "Estilo: ${widget.clothInfoDetail == null ? "No se pudo detectar" : widget.clothInfoDetail?.style}",
                                  style: TextStyle(fontSize: 15),
                                ),
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
}
