import 'package:demo_fashion_app/components/AppBarComponent.dart';
import 'package:demo_fashion_app/views/ClothImagePage.dart';
import 'package:demo_fashion_app/views/GenerateOutfitsPage.dart';
import 'package:demo_fashion_app/views/HomePage.dart';
import 'package:demo_fashion_app/views/MyClothesPage.dart';
import 'package:demo_fashion_app/views/MyOutfitsPage.dart';
import 'package:demo_fashion_app/views/OutfitsPage.dart';
import 'package:demo_fashion_app/views/PaymentSubscriptionPage.dart';
import 'package:demo_fashion_app/views/ProfilePage.dart';
import 'package:demo_fashion_app/views/SubscriptionPage.dart';
import 'package:flutter/material.dart';

class ScaffoldComponent extends StatefulWidget {
  const ScaffoldComponent({Key? key}) : super(key: key);

  @override
  _ScaffoldComponentState createState() => _ScaffoldComponentState();
}

class _ScaffoldComponentState extends State<ScaffoldComponent> {
  int _currentIndex = 0;
  int _subStepIndex = 0;
  late String _appBarTitle = "Seleccionar Prenda";

  final List<String> _titles = [
    "Seleccionar Prenda",
    "Prendas favoritas",
    "Conjuntos Favoritos",
    "Mi Perfil"
  ];

  final List<String> _subTitles = [
    "Seleccionar Prenda",
    "Imagen de la prenda de vestir",
    "Genera conjuntos de ropa",
    "Conjuntos Generados",
  ];

  final List<String> _subTitlesProfile = [
    "Mi perfil",
    "Plan de suscripción",
    "Realizar Pago",
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _subStepIndex = 0;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _subStepIndex = 0;
      _appBarTitle = _titles[_currentIndex];
    });
  }

  void _onSubStepChanged(int index) {
    setState(() {
      _subStepIndex = index;
      _appBarTitle = _subTitles[_subStepIndex];
    });
  }

  void _onSubStepChanged_profile(int index) {
    setState(() {
      _subStepIndex = index;
      _appBarTitle = _subTitlesProfile[_subStepIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Image:' + _pages[_currentIndex],
            ),
          ],
        ),
      ),*/
      resizeToAvoidBottomInset: false,
      appBar: AppBarComponent(title: _appBarTitle),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'Prendas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cuenta',
          ),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return IndexedStack(
          index: _subStepIndex,
          children: [
            HomePage(
              onSubStepChanged: _onSubStepChanged,
            ),
            ClothImagePage(
              onSubStepChanged: _onSubStepChanged,
            ),
            GenerateOutfitsPage(onSubStepChanged: _onSubStepChanged),
            const OutfitsPage(),
            Container(color: Colors.brown),
          ],
        );
      case 1:
        return MyClothesPage(onSubStepChanged: _onSubStepChanged);
      case 2:
        return MyOutfitsPage(onSubStepChanged: _onSubStepChanged);
      case 3:
        return IndexedStack(
          index: _subStepIndex,
          children: [
            ProfilePage(
              onSubStepChanged: _onSubStepChanged_profile,
            ),
            SubscriptionPage(onSubStepChanged: _onSubStepChanged_profile),
            PaymentSubscriptionPage(
                onSubStepChanged: _onSubStepChanged_profile),
          ],
        );
      default:
        return Container();
    }
  }
}
