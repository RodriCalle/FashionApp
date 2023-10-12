import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:color_thief_dart/color_thief_dart.dart';
import 'package:colornames/colornames.dart';
import 'package:demo_fashion_app/utils/utils.dart';
import 'package:huawei_ml_image/huawei_ml_image.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tflite;
import 'package:image/image.dart' as img;
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';
import 'package:tflite_flutter_plus/src/bindings/types.dart';
import 'dart:ui' as ui;

TensorImage _preProcessInput(img.Image image, List<int> inputShape) {
  final inputTensor = TensorImage(TfLiteType.float32);
  inputTensor.loadImage(image);

  final minLength = min(inputTensor.height, inputTensor.width);
  final cropOp = ResizeWithCropOrPadOp(minLength, minLength);

  final shapeLength = inputShape[1];
  final resizeOp = ResizeOp(shapeLength, shapeLength, ResizeMethod.bilinear);

  final normalizeOp = NormalizeOp(127.5, 127.5);

  final imageProcessor = ImageProcessorBuilder()
      .add(cropOp)
      .add(resizeOp)
      .add(normalizeOp)
      .build();

  imageProcessor.process(inputTensor);

  return inputTensor;
}

Future<File> processImageWithESRGAN(File inputImageFile) async {
  final interpreter = await tflite.Interpreter.fromAsset('assets/models/ClothClassification/lite-model_esrgan-tf2_1.tflite');

  final inputShape = interpreter.getInputTensor(0).shape;
  final outputShape = interpreter.getOutputTensor(0).shape;
  final inputType = interpreter.getInputTensor(0).type;
  final outputType = interpreter.getOutputTensor(0).type;

  print('Input shape: $inputShape');
  print('Output shape: $outputShape');
  print('Input type: $inputType');
  print('Output type: $outputType');

  // convertir file a image
  final image = img.decodeImage(inputImageFile.readAsBytesSync())!;
  final inputImage = _preProcessInput(image, inputShape);

  // Define the output buffer
  final outputBuffer = TensorBuffer.createFixedSize(outputShape, TfLiteType.float32);

  try {
    // Realizar la inferencia con la imagen de entrada
    interpreter.run(inputImage.buffer, outputBuffer.buffer);
    print(outputBuffer.buffer.asFloat32List());
  } catch (e) {
    print('Error al ejecutar la inferencia: $e');
  }

  // Crear un archivo para la imagen mejorada
  final enhancedImageBytes = outputBuffer.buffer.asUint8List();
  final pathSaved = await saveTxt(inputImage.toString());
  final enhancedImageFile = File(pathSaved);

  // Liberar los recursos del modelo
  interpreter.close();

  print("imagen mejorada en: ${enhancedImageFile.path}");

  // Devuelve el archivo de la imagen mejorada
  return enhancedImageFile;
}

Future<String> getImageClass(File? inputImageFile) async {
  final interpreter = await tflite.Interpreter.fromAsset('assets/models/ClothClassification/model_cloth_classification.tflite');
  final labels = await FileUtil.loadLabels('assets/models/ClothClassification/labels.txt');

  final inputShape = interpreter.getInputTensor(0).shape;
  final outputShape = interpreter.getOutputTensor(0).shape;
  final inputType = interpreter.getInputTensor(0).type;
  final outputType = interpreter.getOutputTensor(0).type;

  final image = img.decodeImage(inputImageFile?.readAsBytesSync() as List<int>)!;
  final inputImage = _preProcessInput(image, inputShape);

  final outputBuffer = TensorBuffer.createFixedSize(outputShape, TfLiteType.float32);
  var maxIndex = 0;
  try {
    interpreter.run(inputImage.buffer, outputBuffer.buffer);
    final output = outputBuffer.buffer.asFloat32List().toList();
    maxIndex = output.indexWhere((element) => element == output.reduce(max));

    print('Output: $output');
    print('Max index: $maxIndex');
  } catch (e) {
    print('Error al ejecutar la inferencia: $e');
  }

  return labels[maxIndex];
}

Future<String> getMainColorFromImage(File? file) async {

  final bytes = await file!.readAsBytes();
  final buffer = Uint8List.fromList(bytes);
  final codec = await ui.instantiateImageCodec(buffer);
  final frame = await codec.getNextFrame();
  final ui.Image image = frame.image;

  List<int> thiefColor = await getColorFromImage(image, 10) ?? [0, 0, 0];

  print(thiefColor);
  var color = img.Color.fromRgb(thiefColor[0], thiefColor[1], thiefColor[2]);

  return color.colorName;
}

/* Huawei package */
Future<String> getClassWithHuawei(File imageFile) async {
  // Create an MLImageClassificationAnalyzer object.
  MLImageClassificationAnalyzer analyzer = new MLImageClassificationAnalyzer();

// Create an MLClassificationAnalyzerSetting object to configure the recognition.
  final setting = MLClassificationAnalyzerSetting.create(path: imageFile.path, isRemote: false);

// Get the classification results asynchronously.
  List<MLImageClassification> list = await analyzer.asyncAnalyseFrame(setting);

// After the recognition ends, stop classification.
  bool result = await analyzer.stop();

  print(list);

  return "";
}

Future<String> improveImageWithHuawei(File inputImageFile) async {


  final MLImageSuperResolutionAnalyzer analyzer = MLImageSuperResolutionAnalyzer();

  final MLImageSuperResolutionAnalyzerSetting  setting = MLImageSuperResolutionAnalyzerSetting.create(path: inputImageFile.path);

  MLImageSuperResolutionResult result = await analyzer.asyncAnalyseFrame(setting);

  if (result.bytes != null) {
    print("si hay bytes");
    print(result);
    print(result.bytes);
    var url = await saveBytesToPhone(result.bytes!);
    print(url);
  } else {
    print("no hay bytes");
  }

  await analyzer.stop();

  return "";
}