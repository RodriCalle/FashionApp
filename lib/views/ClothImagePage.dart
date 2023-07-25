import 'dart:io';

import 'package:flutter/material.dart';

class ClothImagePage extends StatefulWidget {
  /*final File image;*/

  const ClothImagePage({Key? key}) : super(key: key);

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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
              child: Text("dasds")),
        ],
      );
    });
  }
}
