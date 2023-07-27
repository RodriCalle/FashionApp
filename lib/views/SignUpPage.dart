import 'package:demo_fashion_app/classes/Auth.dart';
import 'package:flutter/material.dart';

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

  final double heightTextFormField = 0.13;

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
                  width: bodyWidth * 0.8,
                  child: Text("Registro", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      width: bodyWidth * 0.8,
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
                      width: bodyWidth * 0.8,
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
                      width: bodyWidth * 0.8,
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
                            onSaved: (value) {
                              accountData.sex = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: bodyWidth * 0.8,
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
                      width: bodyWidth * 0.8,
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
                  width: bodyWidth * 0.65,
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
