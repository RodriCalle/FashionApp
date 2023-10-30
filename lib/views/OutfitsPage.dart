import 'dart:convert';

import 'package:demo_fashion_app/classes/outfit_response.dart';
import 'package:demo_fashion_app/styles/ColorStyles.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class OutfitsPage extends StatefulWidget {
  final List<OutfitResponse> listClothInformation;
  const OutfitsPage({Key? key, required this.listClothInformation}) : super(key: key);

  @override
  State<OutfitsPage> createState() => _OutfitsPageState();
}

class _OutfitsPageState extends State<OutfitsPage> {


  void favoriteImageOutfit(OutfitResponse outfit) async {
    if (outfit.favorite) {
      var response = await FirebaseService().deleteOutfitImage(outfit.id);
      if (response) {
        setState(() {
          outfit.favorite = false;
        });
      }
    }
    else {
      var response = await FirebaseService().uploadOutfitImage(outfit);
      if (response) {
        setState(() {
          outfit.favorite = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double bodyHeight = constraints.maxHeight;
        double bodyWidth = constraints.maxWidth;

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              // child: TextField(
              //   keyboardType: TextInputType.text,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: grey,
              //     // border: border,
              //     // focusedBorder: border,
              //     hintText: "Buscar",
              //     suffixIcon: Icon(Icons.search, color: Colors.black),
              //   ),
              // ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.listClothInformation.length,
                itemBuilder: (context, index) {
                  OutfitResponse outfit = widget.listClothInformation[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                    child: Container(
                      height: bodyHeight * 0.30,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image.network(
                                //   clothInfo.imgUrl,
                                //   height: 130,
                                // ),
                                Image.memory(base64Decode(outfit.imgB64), fit: BoxFit.cover, height: 130),
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: outfit.favorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                                    iconSize: 25,
                                    onPressed: () { favoriteImageOutfit(outfit); },
                                  ),
                                ),

                                Text(
                                  outfit.name,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),

                                MaterialButton(
                                    color: Color.fromRGBO(249, 235, 219, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide.none),
                                    child: const Text("Ver",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    onPressed: () {}
                                ),
                              ],
                            ),
                          )

                          /*Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite_border),
                                onPressed: () {  },
                              ),
                            ],
                          )*/

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
