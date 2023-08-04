import 'package:demo_fashion_app/classes/ClothInfo.dart';
import 'package:demo_fashion_app/styles/ColorStyles.dart';
import 'package:flutter/material.dart';

class OutfitsPage extends StatefulWidget {
  const OutfitsPage({Key? key}) : super(key: key);

  @override
  State<OutfitsPage> createState() => _OutfitsPageState();
}

class _OutfitsPageState extends State<OutfitsPage> {
  List<ClothInfo> clothList = [
    ClothInfo(name: 'Camisa', image: 'https://urbandexmen.com/wp-content/uploads/2022/04/modelo-polo-negro-con-franja.jpg'),
    ClothInfo(name: 'Camisa', image: 'https://urbandexmen.com/wp-content/uploads/2022/04/modelo-polo-negro-con-franja.jpg'),
    ClothInfo(name: 'Camisa', image: 'https://urbandexmen.com/wp-content/uploads/2022/04/modelo-polo-negro-con-franja.jpg'),
    ClothInfo(name: 'Camisa', image: 'https://urbandexmen.com/wp-content/uploads/2022/04/modelo-polo-negro-con-franja.jpg'),
    ClothInfo(name: 'Camisa', image: 'https://urbandexmen.com/wp-content/uploads/2022/04/modelo-polo-negro-con-franja.jpg'),
    ClothInfo(name: 'Camisa', image: 'https://urbandexmen.com/wp-content/uploads/2022/04/modelo-polo-negro-con-franja.jpg'),
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
                  ClothInfo clothInfo = clothList[index];
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
                                clothInfo.image,
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
