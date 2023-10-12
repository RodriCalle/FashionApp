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
        name: 'Polo Azul Casual',
        imgUrl:
            'https://scontent.flim1-2.fna.fbcdn.net/v/t1.6435-9/75223838_2526949124040686_8625086322337382400_n.jpg?stp=dst-jpg_p843x403&_nc_cat=106&ccb=1-7&_nc_sid=7f8c78&_nc_ohc=ZKnR7JbR2mcAX-xzuDb&_nc_ht=scontent.flim1-2.fna&oh=00_AfB53GzuPZnrqfaYT2RplcMXTGUa76HqUAT-n1uFXrKtVw&oe=654FABD1'),
    ClientCloth(
        name: 'Shor Negro Deportivo',
        imgUrl:
            'https://http2.mlstatic.com/D_NQ_NP_621182-MPE47528955604_092021-O.webp'),
    ClientCloth(
        name: 'Polo camisero 3',
        imgUrl:
            'https://hmperu.vtexassets.com/arquivos/ids/3328203/Polo-camisero-de-deporte-en-pique---Negro---H-M-PE.jpg?v=1778514266'),
    ClientCloth(
        name: 'Camisa Blanca Formal',
        imgUrl:
            'https://harleydavidsonlima.com/wp-content/uploads/2017/09/99047_16VMF_WH_T.jpg'),
    ClientCloth(
        name: 'Pantalón Jean',
        imgUrl:
            'https://hmperu.vtexassets.com/arquivos/ids/3788170-483-725/Regular-Jeans---Azul-denim-claro---H-M-PE.jpg?v=638265673275130000'),
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
