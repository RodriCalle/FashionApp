import 'package:demo_fashion_app/styles/ButtonStyles.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key, required this.onSubStepChanged});

  final ValueChanged<int> onSubStepChanged;

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  double priceSuscription = 9.90;

  String priceSuscriptionText = '9.90';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double bodyHeight = constraints.maxHeight;
        double bodyWidth = constraints.maxWidth;

        return Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    widget.onSubStepChanged(0);
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                  iconSize: 30,
                  color: Colors.black,
                ),
              ],
            ),
            Center(
                child: Container(
                    width: bodyWidth * 0.8,
                    height: bodyHeight * 0.7,
                    // margin: const EdgeInsets.fromLTRB(50.0, 80.0, 50, 160.0),
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 0, right: 0, bottom: 0),
                      child: Column(
                        children: [
                          const SizedBox(height: 35),
                          Text(
                            'S/. $priceSuscriptionText',
                            style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ),
                          // const SizedBox(height: 20),
                          const Divider(
                              height: 65,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                              color: Colors.black12),
                          const Column(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Selecciona las prendas que desees combinar sin límite',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      'Accede a combinaciones de outfits ilimitadas',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      'Guarda tus outfits favoritos sin límite',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 50),
                          FilledButton(
                              onPressed: () {
                                widget.onSubStepChanged(2);
                              },
                              style: buttonPrimary,
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Adquirir Plan',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                          const SizedBox(height: 30),
                        ],
                      ),
                    )))
          ],
        );
      },
    );
  }
}
