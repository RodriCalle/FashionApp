import 'dart:io';

import 'package:demo_fashion_app/classes/Auth.dart';
import 'package:demo_fashion_app/services/FirebaseService.dart';
import 'package:demo_fashion_app/styles/BorderStyles.dart';
import 'package:demo_fashion_app/styles/ColorStyles.dart';
import 'package:demo_fashion_app/styles/TextStyles.dart';
import 'package:demo_fashion_app/utils/lists.dart';
import 'package:demo_fashion_app/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final File? image;
  final ValueChanged<int> onSubStepChanged;

  const ProfilePage({super.key, this.image, required this.onSubStepChanged});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formProfileKey = GlobalKey<FormState>();
  bool disabledForm = true;
  Account account = Account();
  final double heightTextFormField = 0.13;

  final _controllerName = TextEditingController();
  final _controllerLastName = TextEditingController();
  final _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    try {
      final userInfo = await FirebaseService().getUserInfo();

      print(userInfo.photoUrl);
      if (userInfo != null) {
        setState(() {
          account.photoUrl = userInfo.photoUrl;
          _controllerName.text = userInfo.names;
          _controllerLastName.text = userInfo.lastNames;
          _controllerEmail.text = userInfo.email;
          account.sex = userInfo.sex;
        });
      }
    } catch (e) {
      print('Error al cargar la información del usuario: $e');
    }
  }

  void _updateInfo() async {
    try {
      final userInfo = await FirebaseService()
          .updateUserInfo(account.names, account.lastNames, account.sex);

      if (userInfo != null) {
        showOverlay(context, "Datos actualizados correctamente.", Colors.green);
      }
    } catch (e) {
      showOverlay(context, e.toString(), Colors.red);
    }
  }

  void _changeProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

      String newPhotoUrl = await FirebaseService().uploadImage(imageTemp);

      setState(() {
        account.photoUrl = newPhotoUrl;
      });
      await FirebaseService().updateProfilePhoto(newPhotoUrl);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double bodyWidth = constraints.maxWidth;

        return SingleChildScrollView(
            child: Container(
                child: Form(
          key: _formProfileKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // Aquí va primero los campos y luego los botones
            children: [
              Container(
                  width: bodyWidth * 0.8,
                  child: Column(
                    // ESTE COLUMN LE PERTENECE A LOS CAMPOS
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Stack(
                          children: [
                            if (disabledForm)
                              Positioned(
                                top: -5,
                                left: 200,
                                child: Container(
                                  child: MaterialButton(
                                      color: const Color.fromRGBO(
                                          249, 235, 219, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide.none),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text("UPGRADE",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10)),
                                      ),
                                      onPressed: () {
                                        setState(() => disabledForm = true);
                                        widget.onSubStepChanged(1);
                                      }),
                                ),
                              ),
                            Column(
                              children: [
                                Container(),
                                Stack(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage( account.photoUrl.isNotEmpty
                                              ? account.photoUrl
                                              : "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg"
                                            )
                                        ),
                                      ),
                                    ),
                                    if (!disabledForm)
                                      Container(
                                          width: bodyWidth * 0.12,
                                          height: bodyWidth * 0.12,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 2,
                                              color: primaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              _changeProfileImage();
                                            },
                                            icon: const Icon(
                                                Icons.camera_alt_outlined),
                                            iconSize: 25,
                                            color: primaryColor,
                                          )),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [Text('Nombres', style: txt17)],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            controller: _controllerName,
                            enabled: disabledForm ? false : true,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: (disabledForm)
                                  ? Colors.black12
                                  : Colors.white,
                              border: border,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              focusedBorder: border,
                              errorBorder: border,
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El campo es obligatorio.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              account.names = value!;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [Text('Apellidos', style: txt17)],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            controller: _controllerLastName,
                            enabled: disabledForm ? false : true,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: (disabledForm)
                                  ? Colors.black12
                                  : Colors.white,
                              border: border,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              focusedBorder: border,
                              errorBorder: border,
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El campo es obligatorio.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              account.lastNames = value!;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [Text('Sexo', style: txt17)],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          DropdownButtonFormField<String>(
                              value: account.sex,
                              focusColor: Colors.white,
                              onChanged: (newValue) {
                                setState(() {
                                  account.sex = newValue!;
                                });
                              },
                              items: options.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  enabled: disabledForm ? false : true,
                                  child: Text(value),
                                );
                              }).toList(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: (disabledForm)
                                    ? Colors.black12
                                    : Colors.white,
                                border: border,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                focusedBorder: border,
                                errorBorder: border,
                                errorStyle: const TextStyle(color: Colors.red),
                              ),
                              borderRadius: BorderRadius.circular(30)),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [Text('Email', style: txt17)],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            controller: _controllerEmail,
                            enabled: false,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black12,
                              border: border,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              focusedBorder: border,
                              errorBorder: border,
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El campo es obligatorio.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              account.email = value!;
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
              if (disabledForm)
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: bodyWidth * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                            color: const Color.fromRGBO(249, 235, 219, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide.none),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Editar Perfil',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ),
                            onPressed: () {
                              setState(() => disabledForm = !disabledForm);
                            }),
                      ],
                    )),
              if (!disabledForm)
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: bodyWidth * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                            color: const Color.fromRGBO(249, 235, 219, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide.none),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Guardar",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ),
                            onPressed: () {
                              if (_formProfileKey.currentState!.validate()) {
                                _formProfileKey.currentState!.save();
                                _updateInfo();
                              }
                              setState(() => disabledForm = true);
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                            color: const Color.fromRGBO(249, 235, 219, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide.none),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Cancelar",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ),
                            onPressed: () {
                              setState(() => disabledForm = true);
                            }),
                      ],
                    )),
            ],
          ),
        )));
      },
    );
  }
}
