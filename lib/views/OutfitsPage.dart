import 'package:demo_fashion_app/styles/ColorStyles.dart';
import 'package:flutter/material.dart';

import '../classes/cloth_info.dart';

class OutfitsPage extends StatefulWidget {
  const OutfitsPage({Key? key}) : super(key: key);

  @override
  State<OutfitsPage> createState() => _OutfitsPageState();
}

class _OutfitsPageState extends State<OutfitsPage> {
  List<ClothInformation> clothList = [
    // polo negro
    /*ClothInformation(name: 'Outfit 1', image: 'https://versach.pe/wp-content/uploads/2023/04/VRS_-_MODELO_FLORIAN-016-600x900.png'),
    ClothInformation(name: 'Outfit 2', image: 'https://dg4uqybrelzrk.cloudfront.net/drago.pe/image/100007184/100007184-2.png'),
    ClothInformation(name: 'Outfit 3', image: 'https://i.pinimg.com/564x/50/32/8b/50328b893d8f0a8d073c4c67d91ce181.jpg'),
    ClothInformation(name: 'Outfit 4', image: 'https://i0.wp.com/deuniformes.es/wp-content/uploads/2020/07/852600-001-delante.jpg?fit=2048%2C2048&ssl=1'),
    ClothInformation(name: 'Outfit 5', image: 'https://i.pinimg.com/564x/12/5e/6d/125e6d9dc03cbcf29121f88653fa4e59.jpg'),
    ClothInformation(name: 'Outfit 6', image: 'https://www.octodenim.com/1215-large_default/polo-cuello-daniel-negro.jpg'),*/

    // polo azul basico
   /* ClothInformation(name: 'Outfit 1', image: 'https://falabella.scene7.com/is/image/FalabellaPE/19915218_4?wid=800&hei=800&qlt=70'),
    ClothInformation(name: 'Outfit 2', image: 'https://falabella.scene7.com/is/image/FalabellaPE/882839951_4?wid=800&hei=800&qlt=70'),
    ClothInformation(name: 'Outfit 3', image: 'https://falabella.scene7.com/is/image/FalabellaPE/19938407_3?wid=800&hei=800&qlt=70'),
    ClothInformation(name: 'Outfit 4', image: 'https://falabella.scene7.com/is/image/FalabellaPE/19813217_4?wid=800&hei=800&qlt=70'),
    ClothInformation(name: 'Outfit 5', image: 'https://falabella.scene7.com/is/image/FalabellaPE/19802607_4?wid=800&hei=800&qlt=70'),*/

    // jogger plomo
    ClothInformation(name: 'Outfit 1', imgUrl: 'https://home.ripley.com.pe/Attachment/WOP_5/2016288919451/2016288919451-4.jpg'),
    ClothInformation(name: 'Outfit 2', imgUrl: 'https://falabella.scene7.com/is/image/FalabellaPE/882836575_4?wid=1004&hei=1500&crop=248,0,1004,1500&qlt=70'),
    ClothInformation(name: 'Outfit 3', imgUrl: 'https://falabella.scene7.com/is/image/FalabellaPE/882834407_1?wid=1004&hei=1500&crop=248,0,1004,1500&qlt=70'),
    ClothInformation(name: 'Outfit 4', imgUrl: "https://images.asos-media.com/products/joggers-de-polar-de-umbro/7763372-4?\$n_320w\$&wid=317&fit=constrain"),
  ];

  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
          color: Colors.black
      )
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double bodyHeight = constraints.maxHeight;
        double bodyWidth = constraints.maxWidth;

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true, // Set this to true to fill the background
                  fillColor: grey, //
                  border: border,
                  focusedBorder: border,
                  hintText: "Buscar",
                  suffixIcon: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: clothList.length,
                itemBuilder: (context, index) {
                  ClothInformation clothInfo = clothList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                    child: Container(
                      height: bodyHeight * 0.23,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                clothInfo.imgUrl,
                                height: 130,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Container(
                                width: 150,
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  iconSize: 25,
                                  onPressed: () {  },
                                ),
                              ),

                              Text(
                                clothInfo.name,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                          fontSize: 18)),
                                  onPressed: () {}
                              ),
                            ],
                          ),

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
