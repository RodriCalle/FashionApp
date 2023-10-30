import 'package:demo_fashion_app/classes/outfit_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../services/firebase_service.dart';

class MyOutfitsPage extends StatefulWidget {
  final ValueChanged<int> onSubStepChanged;
  const MyOutfitsPage({super.key, required this.onSubStepChanged});

  @override
  State<MyOutfitsPage> createState() => _MyOutfitsPageState();
}

class _MyOutfitsPageState extends State<MyOutfitsPage> {
  List<OutfitResponse> outfits = [];

  void favoriteImageOutfit(OutfitResponse outfit) async {
    if (outfit.favorite) {
      var response = await FirebaseService().deleteOutfitImage(outfit.id);
      if (response) {
        outfits.remove(outfit);
        setState(() {});
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
  void initState() {
    super.initState();
    _initialLoad();
  }

  void _initialLoad() async {
    outfits = await FirebaseService().getAllOutfitsSaved();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return outfits.length > 0 ? MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: outfits.length,
        itemBuilder: (context, index) {
          OutfitResponse outfit = outfits[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(top: 18, left: 12, right: 18),
                        child: Image.network(
                          outfit.urlImage,
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
                          onPressed: () { favoriteImageOutfit(outfit); },
                          icon: outfit.favorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                          iconSize: 36,
                        ),
                      )
                    ],
                  ),
                  // MaterialButton(
                  //     color: const Color.fromRGBO(249, 235, 219, 1),
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //         side: BorderSide.none),
                  //     child: const Text("Ver",
                  //         style: TextStyle(
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 14)),
                  //     onPressed: () {
                  //       // widget.onSubStepChanged(1);
                  //     }),
                  const SizedBox(
                    height: 15,
                  )
                ],
              )
            ],
          );
        },
      ) : Container(
        child: Text("No hay conjuntos guardados",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        alignment: Alignment.center,
      );
    });
  }
}
