import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

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


Future<String> saveFile(File file) async {
  final directory = await getExternalStorageDirectory();
  final filePath = '${directory?.path}/image_${DateTime.now().toString()}.jpg';

  try {
    await file.copy(filePath);
  } catch (e) {
    print('Error al guardar el archivo: $e');
  }
  return filePath;
}

Future<String> saveBytesImageToFile(Uint8List bytes) async {
  final directory = await getExternalStorageDirectory();
  final now = DateTime.now();
  final filePath = '${directory?.path}/image_${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}.jpg';

  try {
    final image = img.decodeImage(bytes);
    if (image != null) {
      File(filePath).writeAsBytesSync(img.encodeJpg(image));
    }

  } catch (e) {
    print('Error al guardar el archivo: $e');
  }
  return filePath;
}

Future<String> saveBytesToPhone(Uint8List bytes) async {

  final directory = await getExternalStorageDirectory();
  final now = DateTime.now();
  final filePath = '${directory?.path}/image_${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}.jpg';

  try {
    final file = File(filePath);
    await file.writeAsBytes(bytes);
  } catch (e) {
    print('Error al guardar el archivo: $e');
  }

  return filePath;
}

Future<String> saveTxt(String txt, [String? name]) async {
  final directory = await getExternalStorageDirectory();
  final now = DateTime.now();
  final filePath = '${directory?.path}/${name ?? "txt"}_${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}.txt';

  try {
    final file = File(filePath);
    await file.writeAsString(txt);
  } catch (e) {
    print('Error al guardar el archivo: $e');
  }

  return filePath;
}

//save uint8list to file temporary
Future<File> saveBytesImageToTemporaryFile(Uint8List bytes, String fileName) async {
  try {
    final appDir = await getTemporaryDirectory();
    final file = File('${appDir.path}/$fileName');

    await file.writeAsBytes(bytes);

    return file;
  } catch (e) {
    throw Exception('Error al guardar la imagen: $e');
  }
}

String getFormattedCurrentDateTime() {
  final now = DateTime.now();
  final formattedDate = "${now.year}-${now.month}-${now.day}";
  final formattedTime = "${now.hour}-${now.minute}-${now.second}";
  return "$formattedDate-$formattedTime";
}
