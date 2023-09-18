import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

Future<Float32List> prepareImageForModel(File imageFile) async {
  // Leer la imagen del archivo
  final bytes = await imageFile.readAsBytes();
  img.Image? image = await img.decodeImage(Uint8List.fromList(bytes));

  // Redimensionar la imagen a un tamaño máximo de 50x50 píxeles
  final resizedImage = img.copyResize(image!, width: 50, height: 50);

  // Normalizar los valores de píxeles al rango [0, 1]
  final normalizedImage = resizedImage.getBytes(format: img.Format.rgb);

  // Crear un Float32List a partir de los valores float32
  final inputFloat32 = Float32List.fromList(normalizedImage.map((value) => value / 255.0).toList());

  return inputFloat32;
}

Future<File?> processImageWithESRGAN(File inputImageFile) async {
  // Cargar el modelo ESRGAN
  final interpreter = await Interpreter.fromAsset(
    'assets/models/lite-model_esrgan-tf2_1.tflite', // Ruta al modelo
  );

  // Preparar la imagen de entrada
  final inputImageBytes = await prepareImageForModel(inputImageFile);

  // Verificar si la imagen de entrada es válida
  if (inputImageBytes == null || inputImageBytes.isEmpty) {
    throw Exception('No se pudo procesar la imagen.');
  }

  // Crear una lista de salida para la imagen mejorada
  final outputImageBytes = List<int>.filled(inputImageBytes.length, 0);

  try {
    // Realizar la inferencia con la imagen de entrada
    interpreter.run(inputImageBytes, outputImageBytes);
  } catch (e) {
    print('Error al ejecutar la inferencia: $e');
  }

  // Verificar si la salida es válida
  if (outputImageBytes == null || outputImageBytes.isEmpty) {
    throw Exception('No se pudo procesar la imagen.');
  }

  // Crear un archivo para la imagen mejorada
  final enhancedImageFile = File('assets/improved/${DateTime.now().toString()}.jpg');

  // Guardar la imagen mejorada en el archivo
  await enhancedImageFile.writeAsBytes(outputImageBytes);

  // Liberar los recursos del modelo
  interpreter.close();

  // Devuelve el archivo de la imagen mejorada
  return enhancedImageFile;
}