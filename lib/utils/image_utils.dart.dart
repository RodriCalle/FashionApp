import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:color_thief_dart/color_thief_dart.dart';
import 'package:colornames/colornames.dart';
import 'package:demo_fashion_app/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tflite;
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
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

/*Future<String> getImageColor(File? inputImageFile) async {
  // file to image
  final image = img.decodeImage(inputImageFile?.readAsBytesSync() as List<int>)!;
  // get color from image
  var color = getColorFromImage(image, 1);
}*/

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

Future<String> removeBackground(File inputImage) async {
  var apiKey = "GVwSVQzvbhMfRqZL6G1jvTnM";
  var path = "";

  final imageBytes = await inputImage.readAsBytes();

  final response = await http.post(
    Uri.parse('https://api.remove.bg/v1.0/removebg'),
    headers: {
      'X-Api-Key': apiKey,
    },
    body: imageBytes,
  );

  if (response.statusCode == 200) {
    final outputImageBytes = response.bodyBytes;
    path = await saveBytesImageToFile(outputImageBytes);
  } else {
    // Maneja el error aquí
    print('Error al eliminar el fondo: ${response.statusCode}');
  }

  return path;
}

Future<String> removeBackground2(File file) async {
  final apiKey = "Basic MTc2MDc6dG1hYjRqMTJvOHVlMGUxYWdwMG9qMDFmcThjcG0zcmk0bTU4aXIzaXE4c2ZpdXNrZGY4dA==";
  var path = "";
  final uri = Uri.parse("https://clippingmagic.com/api/v1/images");

  final request = http.MultipartRequest('POST', uri)
    ..headers['Authorization'] = apiKey
    ..fields['format'] = 'result'
    ..fields['test'] = 'true';

  final fileStream = http.ByteStream(file.openRead());
  final fileLength = await file.length();

  final fileName = basename(file.path);

  request.files.add(http.MultipartFile(
    'image',
    fileStream,
    fileLength,
    filename: fileName,
    contentType: MediaType('image', 'jpg'),
  ));

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseData = await response.stream.toBytes();
    path = await saveBytesImageToFile(responseData);
  } else {
    print("Request Failed: Status: ${response.statusCode}, Reason: ${response.reasonPhrase}");
  }

  return path;
}

Future<String> removeBackground3(File imageFile) async {
  var path = "";
  final url = Uri.parse("https://api.removal.ai/3.0/remove");
  final headers = {
    'Rm-Token': '6513265b2874e6.77515485',
  };

  final request = http.MultipartRequest('POST', url)
    ..headers.addAll(headers)
    ..files.add(await http.MultipartFile.fromPath(
      'image_file',
      imageFile.path,
      contentType: MediaType('image', 'jpg'),
    ));

  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.toBytes();
      path = await saveBytesImageToFile(responseBody);
    } else {
      print("Request Failed: Status: ${response.statusCode}, Reason: ${response.reasonPhrase}");
    }
  } catch (e) {
    print("Error: $e");
  }

  return path;
}