import 'package:demo_fashion_app/classes/Auth.dart';
import 'package:demo_fashion_app/services/FirebaseService.dart';
import 'package:demo_fashion_app/styles/TextStyles.dart';
import 'package:demo_fashion_app/views/LoginPage.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  Account accountData = new Account();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.white),
  );

  final double heightTextFormField = 0.13;

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await FirebaseService().createUserWithEmailAndPassword(
          accountData.email,
          accountData.password,
          accountData.names,
          accountData.lastNames,
          accountData.sex,
        );

        // La cuenta se creó exitosamente, puedes realizar acciones adicionales.
      } catch (e) {
        print("Error durante el registro: $e");
        showOverlay(context, e.toString(), Colors.red);
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
                                style: txt20,
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
                                style: txt20,
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
                                style: txt20,
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
                                style: txt20,
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
                                style: txt20,
                              ),
                            ],
                          ),
                          TextFormField(
                            obscureText: _obscureText,
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
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
