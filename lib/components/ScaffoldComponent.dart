import 'dart:io';

import 'package:demo_fashion_app/classes/cloth_information.dart';
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
import 'package:demo_fashion_app/utils/lists.dart';
import 'package:flutter/material.dart';

import '../classes/outfit_response.dart';

class ScaffoldComponent extends StatefulWidget {
  const ScaffoldComponent({Key? key}) : super(key: key);

  @override
  _ScaffoldComponentState createState() => _ScaffoldComponentState();
}

class _ScaffoldComponentState extends State<ScaffoldComponent> {
  int _currentIndex = 0;
  int _subStepIndex = 0;
  late String _appBarTitle = "Seleccionar Prenda";
  File? imageSelected;
  ClothInformation clothInfoDetail = ClothInformation();
  List<OutfitResponse> listClothInformation = [];

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
      _appBarTitle = titles[_currentIndex];
    });
  }

  void _onSubStepChanged(int index) {
    // print("index ${index}");
    setState(() {
      _subStepIndex = index;
      _appBarTitle = subTitles[_subStepIndex];
    });
  }

  void _onImageSelected(File image) {
    print(image.path);
    setState(() {
      imageSelected = image;
    });
  }

  void _onClothInfoDetail(ClothInformation clothInfoD) {
    setState(() {
      clothInfoDetail = clothInfoD;
    });
  }

  void _onListClothInformation(List<OutfitResponse> list) {
    setState(() {
      listClothInformation = list;
    });
  }

  void _onSubStepChanged_profile(int index) {
    setState(() {
      _subStepIndex = index;
      _appBarTitle = subTitlesProfile[_subStepIndex];
    });
  }

  void _onSubStepChangedClothes(int index) {
    setState(() {
      _subStepIndex = index;
      _appBarTitle = subTitlesClothes[_subStepIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onImageSelected: _onImageSelected
            ),
            ClothImagePage(
              image: imageSelected,
              onSubStepChanged: _onSubStepChanged,
              onImageSelected: _onImageSelected,
              onClothInfoDetail: _onClothInfoDetail,
            ),
            GenerateOutfitsPage(
              image: imageSelected,
              onSubStepChanged: _onSubStepChanged,
              onImageSelected: _onImageSelected,
              onListClothInformation: _onListClothInformation,
              clothInfoDetail: clothInfoDetail,
            ),
            OutfitsPage(
              listClothInformation: listClothInformation,
            ),
            Container(color: Colors.brown),
          ],
        );
      case 1:
        return IndexedStack(
          index: _subStepIndex,
          children: [
            MyClothesPage(onSubStepChanged: _onSubStepChanged),
            GenerateOutfitsPage(
                image: imageSelected,
                onSubStepChanged: _onSubStepChanged,
                onImageSelected: _onImageSelected,
                onListClothInformation: _onListClothInformation,
                clothInfoDetail: clothInfoDetail,
            ),
          ],
        );
      case 2:
        return IndexedStack(
          index: _subStepIndex,
          children: [
            MyOutfitsPage(onSubStepChanged: _onSubStepChanged),
            // const OutfitsPage()
          ],
        );
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
