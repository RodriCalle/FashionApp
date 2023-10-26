import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../classes/cloth_info.dart';

class MyOutfitsPage extends StatefulWidget {
  final ValueChanged<int> onSubStepChanged;
  const MyOutfitsPage({super.key, required this.onSubStepChanged});

  @override
  State<MyOutfitsPage> createState() => _MyOutfitsPageState();
}

class _MyOutfitsPageState extends State<MyOutfitsPage> {
  List<ClothInformation> clothList = [
    ClothInformation(
        name: 'Conjunto 1',
        imgUrl:
            'https://thumbs.dreamstime.com/b/joven-en-traje-de-mezclilla-guapo-hombre-con-chaqueta-y-jeans-sobre-fondo-blanco-foto-para-publicidad-mens-los-hombres-chaquetas-207855357.jpg'),
    ClothInformation(
        name: 'Conjunto 2',
        imgUrl:
            'https://hmperu.vtexassets.com/arquivos/ids/3289579-483-725/Loose-Jeans---Denim-blue---H-M-PE.jpg?v=638080789991570000'),
    ClothInformation(
        name: 'Conjunto 3',
        imgUrl:
            'https://http2.mlstatic.com/D_NQ_NP_702623-MLC49365086260_032022-O.webp'),
    ClothInformation(
        name: 'Conjunto 4',
        imgUrl:
            'https://hmperu.vtexassets.com/arquivos/ids/3787717-483-725/Regular-Tapered-Jeans---Negro-No-fade-black---H-M-PE.jpg?v=638265670132530000'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: clothList.length,
        itemBuilder: (context, index) {
          ClothInformation clientOutfitInfo = clothList[index];
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
                          clientOutfitInfo.imgUrl,
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
                        // widget.onSubStepChanged(1);
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
