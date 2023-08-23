import 'package:demo_fashion_app/classes/Auth.dart';
import 'package:demo_fashion_app/components/ScaffoldComponent.dart';
import 'package:demo_fashion_app/views/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey para el formulario
  Login loginData = new Login();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.black),
  );

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: loginData.email,
          password: loginData.password,
        );

        // El inicio de sesión fue exitoso, puedes realizar acciones adicionales o navegar a otra página.
        print("Inicio de sesión exitoso: ${userCredential.user!.uid}");


        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScaffoldComponent()),
        );
      } catch (e) {
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
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  width: bodyWidth * 0.4,
                  child: Image.asset('assets/images/logo_fashion_app.png'),
                ),
                Container(
                  /* decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),*/
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: bodyWidth * 0.65,
                        height: bodyHeight * 0.12,
                        /*decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),*/
                        child: TextFormField(
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Correo Electronico',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
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
                            loginData.email = value!;
                          },
                        ),
                      ),
                      Container(
                        width: bodyWidth * 0.65,
                        height: bodyHeight * 0.12,
                        child: TextFormField(
                          obscureText: true,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Contraseña',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
                            border: border,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            focusedBorder: border,
                            errorBorder: border,
                            errorStyle: TextStyle(color: Colors.red),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingresa tu contraseña';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            loginData.password = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                  width: bodyWidth * 0.65,
                  child: MaterialButton(
                      color: Color.fromRGBO(249, 235, 219, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide.none),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Iniciar Sesión",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                      onPressed: _login),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿Todavía no tienes cuenta?",
                        style: TextStyle(decoration: TextDecoration.underline)),
                    TextButton(
                      child: const Text(
                        " Haz clic aquí",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
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
