import 'package:demo_fashion_app/classes/ClientCloth.dart';
import 'package:demo_fashion_app/classes/ClientClothes.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        double bodyWidth = constraints.maxWidth;
        double bodyHeight = constraints.maxHeight;
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: clothList.length,
                  itemBuilder: (context, index) {
                    ClientCloth clientClothInfo = clothList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 25),
                      child: Container(
                        height: bodyHeight * 0.23,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  clientClothInfo.imgUrl,
                                  height: 130,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Container(
                                //   width: 160,
                                //   alignment: Alignment.topRight,
                                //   child: IconButton(
                                //     icon: Icon(Icons.delete_outline),
                                //     iconSize: 30,
                                //     onPressed: () {},
                                //   ),
                                // ),
                                Text(
                                  clientClothInfo.name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                            fontSize: 15)),
                                    onPressed: () {}),
                                MaterialButton(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide.none),
                                    child: const Text("Quitar",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                    onPressed: () {
                                      setState(() {
                                        clothList.removeAt(index);
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
