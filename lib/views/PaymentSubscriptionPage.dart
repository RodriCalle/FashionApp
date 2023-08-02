import 'package:demo_fashion_app/classes/CreditCardAcount.dart';
import 'package:demo_fashion_app/styles/ButtonStyles.dart';
import 'package:flutter/material.dart';

class PaymentSubscriptionPage extends StatefulWidget {
  const PaymentSubscriptionPage({super.key, required this.onSubStepChanged});

  final ValueChanged<int> onSubStepChanged;

  @override
  State<PaymentSubscriptionPage> createState() =>
      _PaymentSubscriptionPageState();
}

class _PaymentSubscriptionPageState extends State<PaymentSubscriptionPage> {
  final _formPaymentKey = GlobalKey<FormState>();

  // Controladores de dato
  final _controllerCard = TextEditingController();
  final _controllerDate = TextEditingController();
  final _controllerCcv = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerLastName = TextEditingController();
  final _controllerEmail = TextEditingController();

  final CreditCardAcount acountData = CreditCardAcount();

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(color: Colors.white),
  );

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('La transacción se ha completado exitosamente'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double bodyWidth = constraints.maxWidth;

        return SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    widget.onSubStepChanged(1);
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                  iconSize: 30,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Container(
                    width: bodyWidth * 0.9,
                    // height: bodyHeight * 0.7,
                    // margin: const EdgeInsets.fromLTRB(50.0, 80.0, 50, 160.0),
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formPaymentKey,
                          child: Column(children: [
                            const SizedBox(
                              height: 35,
                            ),
                            TextFormField(
                              controller: _controllerCard,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: border,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                focusedBorder: border,
                                errorBorder: border,
                                errorStyle: const TextStyle(color: Colors.red),
                                hintText: 'Nro de Tarjeta',
                                hintStyle: const TextStyle(
                                  fontStyle:
                                      FontStyle.italic, // Estilo en cursiva
                                  color: Colors.grey, // Color del texto
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El campo no debe quedar vacío.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                acountData.clientEmail = value!;
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: bodyWidth * .38,
                                  child: TextFormField(
                                    controller: _controllerDate,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: border,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                      focusedBorder: border,
                                      errorBorder: border,
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      hintText: 'Fecha Ven.',
                                      hintStyle: const TextStyle(
                                        fontStyle: FontStyle
                                            .italic, // Estilo en cursiva
                                        color: Colors.grey, // Color del texto
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'El campo no debe quedar vacío.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      acountData.dueDate = value!;
                                    },
                                  ),
                                ),
                                Container(
                                  width: bodyWidth * .38,
                                  child: TextFormField(
                                    controller: _controllerCcv,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: border,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                      focusedBorder: border,
                                      errorBorder: border,
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      hintText: 'CCV',
                                      hintStyle: const TextStyle(
                                        fontStyle: FontStyle
                                            .italic, // Estilo en cursiva
                                        color: Colors.grey, // Color del texto
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'El campo no debe quedar vacío.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      acountData.ccvCode = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: bodyWidth * .38,
                                  child: TextFormField(
                                    controller: _controllerName,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: border,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                      focusedBorder: border,
                                      errorBorder: border,
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      hintText: 'Nombre',
                                      hintStyle: const TextStyle(
                                        fontStyle: FontStyle
                                            .italic, // Estilo en cursiva
                                        color: Colors.grey, // Color del texto
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'El campo no debe quedar vacío.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      acountData.clientName = value!;
                                    },
                                  ),
                                ),
                                Container(
                                  width: bodyWidth * .38,
                                  child: TextFormField(
                                    controller: _controllerLastName,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: border,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                      focusedBorder: border,
                                      errorBorder: border,
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      hintText: 'Apellido',
                                      hintStyle: const TextStyle(
                                        fontStyle: FontStyle
                                            .italic, // Estilo en cursiva
                                        color: Colors.grey, // Color del texto
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'El campo no debe quedar vacío.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      acountData.clientLastName = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _controllerEmail,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: border,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                focusedBorder: border,
                                errorBorder: border,
                                errorStyle: const TextStyle(color: Colors.red),
                                hintText: 'Correo electrónico',
                                hintStyle: const TextStyle(
                                  fontStyle:
                                      FontStyle.italic, // Estilo en cursiva
                                  color: Colors.grey, // Color del texto
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El campo no debe quedar vacío.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                acountData.clientEmail = value!;
                              },
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            FilledButton(
                              style: buttonPrimary,
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Pagar S/. 9.90',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formPaymentKey.currentState!.validate()) {
                                  _formPaymentKey.currentState!.save();
                                  _showConfirmationDialog(context);
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                          ]),
                        ))))
          ],
        ));
      },
    );
  }
}
