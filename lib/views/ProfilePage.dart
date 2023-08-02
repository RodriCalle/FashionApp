import 'dart:io';

import 'package:demo_fashion_app/classes/ClientProfile.dart';
// import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final File? image;
  final ValueChanged<int> onSubStepChanged;

  const ProfilePage({super.key, this.image, required this.onSubStepChanged});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formPorfileKey = GlobalKey<FormState>();
  String name = 'Daniel';
  String lastName = 'Santillán Ávila';
  String gender = 'Masculino';
  String email = 'danielSan07@gmail.com';

  // Controladores de dato
  final _controllerName = TextEditingController();
  final _controllerLastName = TextEditingController();
  final _controllerGender = TextEditingController();
  final _controllerEmail = TextEditingController();

  final Profile profileData =
      Profile('Daniel', 'Santillán', 'Masculino', 'danielsan07@gmail.com');
  // final Profile proData = Profile(name, lastName, gender, email);

  final double heightTextFormField = 0.13;

  bool disabledForm = true;

  final TextStyle txtStyle = const TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.white),
  );

  @override
  void initState() {
    super.initState();
    _controllerName.text = profileData.name;
    _controllerLastName.text = profileData.lastName;
    _controllerGender.text = profileData.gender;
    _controllerEmail.text = profileData.email;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double bodyWidth = constraints.maxWidth;

        return SingleChildScrollView(
            child: Container(
                child: Form(
          key: _formPorfileKey,
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
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'https://image.winudf.com/v2/image1/bmV0LndsbHBwci5ib3lzX3Byb2ZpbGVfcGljdHVyZXNfc2NyZWVuXzBfMTY2NzUzNzYxN18wOTk/screen-0.webp?fakeurl=1&type=.webp')),
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
                                              color: Colors.black45,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              changeProfileImage();
                                            },
                                            icon: const Icon(
                                                Icons.camera_alt_outlined),
                                            iconSize: 25,
                                            color: Colors.black45,
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
                            children: [Text('Nombres', style: txtStyle)],
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
                                return 'El campo no debe quedar vacío.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              profileData.name = value!;
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
                            children: [Text('Apellidos', style: txtStyle)],
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
                                return 'El campo no debe quedar vacío.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              profileData.lastName = value!;
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
                            children: [Text('Sexo', style: txtStyle)],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            controller: _controllerGender,
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
                                return 'El campo no debe quedar vacío.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              profileData.gender = value!;
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
                            children: [Text('Email', style: txtStyle)],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            controller: _controllerEmail,
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
                                return 'El campo no debe quedar vacío.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              profileData.email = value!;
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
                              if (_formPorfileKey.currentState!.validate()) {
                                _formPorfileKey.currentState!.save();
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

changeProfileImage() {}
