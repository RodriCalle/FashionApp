import 'package:flutter/material.dart';

import '../classes/ClothInfo.dart';

class MyOutfitsPage extends StatefulWidget {
  final ValueChanged<int> onSubStepChanged;
  const MyOutfitsPage({super.key, required this.onSubStepChanged});

  @override
  State<MyOutfitsPage> createState() => _MyOutfitsPageState();
}

class _MyOutfitsPageState extends State<MyOutfitsPage> {
  List<ClothInfo> clothList = [
    ClothInfo(
        name: 'Conjunto 1',
        image:
            'https://thumbs.dreamstime.com/b/joven-en-traje-de-mezclilla-guapo-hombre-con-chaqueta-y-jeans-sobre-fondo-blanco-foto-para-publicidad-mens-los-hombres-chaquetas-207855357.jpg'),
    ClothInfo(
        name: 'Conjunto 2',
        image:
            'https://thumbs.dreamstime.com/b/joven-en-traje-de-mezclilla-guapo-hombre-con-chaqueta-y-jeans-sobre-fondo-blanco-foto-para-publicidad-mens-los-hombres-chaquetas-207855357.jpg'),
    ClothInfo(
        name: 'Conjunto 3',
        image:
            'https://thumbs.dreamstime.com/b/joven-en-traje-de-mezclilla-guapo-hombre-con-chaqueta-y-jeans-sobre-fondo-blanco-foto-para-publicidad-mens-los-hombres-chaquetas-207855357.jpg'),
    ClothInfo(
        name: 'Conjunto 4',
        image:
            'https://thumbs.dreamstime.com/b/joven-en-traje-de-mezclilla-guapo-hombre-con-chaqueta-y-jeans-sobre-fondo-blanco-foto-para-publicidad-mens-los-hombres-chaquetas-207855357.jpg'),
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
                    ClothInfo clientOutfitInfo = clothList[index];
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
                                  clientOutfitInfo.image,
                                  height: 130,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  clientOutfitInfo.name,
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
