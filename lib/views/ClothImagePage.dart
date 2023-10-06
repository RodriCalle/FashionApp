import 'dart:io';

import 'package:demo_fashion_app/classes/ClothInfoDetail.dart';
import 'package:demo_fashion_app/utils/image_utils.dart.dart';
import 'package:flutter/material.dart';


class ClothImagePage extends StatefulWidget {
  final File? image;
  final ValueChanged<int> onSubStepChanged;
  final ValueChanged<File> onImageSelected;
  final ValueChanged<ClothInfoDetail> onClothInfoDetail;

  ClothImagePage({Key? key, this.image,
    required this.onSubStepChanged, required this.onImageSelected, required this.onClothInfoDetail})
      : super(key: key);

  @override
  State<ClothImagePage> createState() => _ClothImagePageState();
}

class _ClothImagePageState extends State<ClothImagePage> {

  void improveImage() async {
    //final imgEnhanced = await processImageWithESRGAN(imageTemp);
    //final path = await improveImageWithHuawei(widget.image!);
    ClothInfoDetail clothInfoDetail = ClothInfoDetail();
    clothInfoDetail.type = await getImageClass(widget.image);
    // await getClass(widget.image!);
    //var pathImageNoBg = await removeBackground(widget.image!);
    //var pathImageNoBg2 = await removeBackground2(widget.image!);
    //var pathImageNoBg2 = await removeBackground3(widget.image!);
    clothInfoDetail.color = await getMainColorFromImage(widget.image!);
    clothInfoDetail.material = "Cotton";
    clothInfoDetail.style = "Casual";

    widget.onImageSelected(widget.image!);
    widget.onClothInfoDetail(clothInfoDetail);
    widget.onSubStepChanged(2);
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
                                child: Text("Mejorar Imagen",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
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

}
