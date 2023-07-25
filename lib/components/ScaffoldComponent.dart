import 'dart:io';

import 'package:demo_fashion_app/components/AppBarComponent.dart';
import 'package:demo_fashion_app/utils/Pair.dart';
import 'package:demo_fashion_app/views/Home.dart';
import 'package:flutter/material.dart';

class ScaffoldComponent extends StatefulWidget {

  const ScaffoldComponent({Key? key}) : super(key: key);

  @override
  _ScaffoldComponentState createState() =>
      _ScaffoldComponentState();
}

class _ScaffoldComponentState
    extends State<ScaffoldComponent> {
  int _currentIndex = 0;

  final List<Widget> _views = [
    HomePage(),
  ];

  final List<String> _nameViews = [
    "Seleccionar Prenda",
    "Prendas favoritas",
    "Conjuntos Favoritos",
    "Mi Perfil"
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_currentIndex],
      appBar: AppBarComponent(title: _nameViews[_currentIndex]),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'CheckRoom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
      ),
    );
  }
}