import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

import '../classes/cloth_information.dart';
import '../services/firebase_service.dart';

class MyClothesPage extends StatefulWidget {
  final ValueChanged<int> onSubStepChanged;

  const MyClothesPage({super.key, required this.onSubStepChanged});

  @override
  State<MyClothesPage> createState() => _MyClothesPageState();
}

class _MyClothesPageState extends State<MyClothesPage> {
  List<ClothInformation> cloths = [];

  void deleteFavoriteImageCloth(ClothInformation cloth) async {
    if (cloth.favorite) {
      var response = await FirebaseService().deleteClothImage(cloth.id);
      if (response) {
        setState(() {
          cloths.remove(cloth);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return cloths.length > 0
          ? MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: cloths.length,
              itemBuilder: (context, index) {
                ClothInformation cloth = cloths[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 18, left: 12, right: 18),
                              child: Image.network(
                                cloth.urlImage,
                                height: 135,
                                width: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: -6,
                              right: -9,
                              // left: -23,
                              child: IconButton(
                                icon: cloth.favorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                                iconSize: 25, //36,
                                onPressed: () { deleteFavoriteImageCloth(cloth); },
                              ),
                            )
                          ],
                        ),
                        /*MaterialButton(
                            color: const Color.fromRGBO(249, 235, 219, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide.none),
                            child: const Text("Ver",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            onPressed: () {
                              widget.onSubStepChanged(1);
                            }),*/
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    )
                  ],
                );
              },
            )
          : Container(
              child: Text(
                "No hay prendas de vestir guardadas",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            );
      ;
    });
  }
}
