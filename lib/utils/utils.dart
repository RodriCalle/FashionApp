import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void showOverlay(BuildContext context, String message, Color? color) {
  OverlayState? overlayState = Overlay.of(context);

  OverlayEntry overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color == null ? Colors.red : color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ),
      );
    },
  );

  overlayState.insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}


List<String> options = [
  'Masculino',
  'Femenino',
  'Prefiero no decirlo',
];

Future<String> saveFile(File file) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/${DateTime.now().toString()}.jpg';

  try {
    await file.copy(filePath);
  } catch (e) {
    print('Error al guardar el archivo: $e');
  }
  return filePath;
}
