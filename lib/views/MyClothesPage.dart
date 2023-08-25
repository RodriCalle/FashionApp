import 'package:demo_fashion_app/classes/ClientCloth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class MyClothesPage extends StatefulWidget {
  final ValueChanged<int> onSubStepChanged;

  const MyClothesPage({super.key, required this.onSubStepChanged});

  @override
  State<MyClothesPage> createState() => _MyClothesPageState();
}

class _MyClothesPageState extends State<MyClothesPage> {
  List<ClientCloth> clothList = [
    ClientCloth(
        name: 'Polo camisero 1',
        imgUrl:
            'https://hmperu.vtexassets.com/arquivos/ids/3328203/Polo-camisero-de-deporte-en-pique---Negro---H-M-PE.jpg?v=1778514266'),
    ClientCloth(
        name: 'Polo camisero 2',
        imgUrl:
            'https://hmperu.vtexassets.com/arquivos/ids/3328203/Polo-camisero-de-deporte-en-pique---Negro---H-M-PE.jpg?v=1778514266'),
    ClientCloth(
        name: 'Polo camisero 3',
        imgUrl:
            'https://hmperu.vtexassets.com/arquivos/ids/3328203/Polo-camisero-de-deporte-en-pique---Negro---H-M-PE.jpg?v=1778514266'),
    ClientCloth(
        name: 'Polo camisero 4',
        imgUrl:
            'https://hmperu.vtexassets.com/arquivos/ids/3328203/Polo-camisero-de-deporte-en-pique---Negro---H-M-PE.jpg?v=1778514266'),
    ClientCloth(
        name: 'Polo camisero 5',
        imgUrl:
            'https://hmperu.vtexassets.com/arquivos/ids/3328203/Polo-camisero-de-deporte-en-pique---Negro---H-M-PE.jpg?v=1778514266'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: clothList.length,
        itemBuilder: (context, index) {
          ClientCloth clientClothInfo = clothList[index];
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
                          clientClothInfo.imgUrl,
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
                          onPressed: () {
                            {}
                          },
                          icon: const Icon(Icons.favorite),
                          iconSize: 36,
                        ),
                      )
                    ],
                  ),
                  MaterialButton(
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
                      }),
                  const SizedBox(
                    height: 15,
                  )
                ],
              )
            ],
          );
        },
      );
    });
  }
}
