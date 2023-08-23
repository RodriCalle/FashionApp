import 'package:demo_fashion_app/classes/Auth.dart';
import 'package:demo_fashion_app/views/LoginPage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  Account accountData = new Account();

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.white),
  );

  final TextStyle txtStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  List<String> options = [
    'Masculino',
    'Femenino',
    'Prefiero no decirlo',
  ];

  final double heightTextFormField = 0.13;

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: accountData.email,
          password: accountData.password,
        );

        print(userCredential);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'names': accountData.names,
          'lastNames': accountData.lastNames,
          'sex': accountData.sex,
          'photoUrl':
              "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg"
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        print("Error durante el registro: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double bodyHeight = constraints.maxHeight;
      double bodyWidth = constraints.maxWidth;

      return Material(
        color: Colors.black,
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  width: bodyWidth * 0.75,
                  child: Text("Registro",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: bodyWidth * 0.75,
                      height: bodyHeight * heightTextFormField,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Nombres",
                                style: txtStyle,
                              ),
                            ],
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: border,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              focusedBorder: border,
                              errorBorder: border,
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa tu nombre.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              accountData.names = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: bodyWidth * 0.75,
                      height: bodyHeight * heightTextFormField,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Apellidos",
                                style: txtStyle,
                              ),
                            ],
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: border,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              focusedBorder: border,
                              errorBorder: border,
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa tus apellidos.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              accountData.lastNames = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: bodyWidth * 0.75,
                      height: bodyHeight * heightTextFormField,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Sexo",
                                style: txtStyle,
                              ),
                            ],
                          ),
                          DropdownButtonFormField<String>(
                              value: options.first,
                              focusColor: Colors.white,
                              onChanged: (newValue) {
                                setState(() {
                                  accountData.sex = newValue!;
                                });
                              },
                              items: options.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                border: border,
                                focusedBorder: border,
                                errorBorder: border,
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 18),
                              ),
                              borderRadius: BorderRadius.circular(30)),
                        ],
                      ),
                    ),
                    Container(
                      width: bodyWidth * 0.75,
                      height: bodyHeight * heightTextFormField,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Correo electronico",
                                style: txtStyle,
                              ),
                            ],
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: border,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              focusedBorder: border,
                              errorBorder: border,
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa tu correo electronico.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              accountData.email = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: bodyWidth * 0.75,
                      height: bodyHeight * heightTextFormField,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Contraseña",
                                style: txtStyle,
                              ),
                            ],
                          ),
                          TextFormField(
                            obscureText: true,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: border,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              focusedBorder: border,
                              errorBorder: border,
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa tu contraseña.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              accountData.password = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: bodyWidth * 0.75,
                  child: MaterialButton(
                      color: Color.fromRGBO(249, 235, 219, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide.none),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Registrar",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                      onPressed: _signUp
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿Ya tienes una cuenta?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white)),
                    TextButton(
                      child: const Text(
                        " Inicia sesión",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
