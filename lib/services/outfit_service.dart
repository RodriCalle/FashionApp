import 'dart:convert';
import 'dart:io';
import 'package:demo_fashion_app/classes/cloth_request.dart';
import 'package:demo_fashion_app/classes/outfit_response.dart';
import 'package:demo_fashion_app/services/color_service.dart';
import 'package:http/http.dart' as http;
import '../classes/cloth_information.dart';
// import 'package:image/image.dart' as img;

var url_base = 'http://159.89.95.94:8888/';

Map<String, String> headers = {
  'Content-Type': 'application/json',
};

Future<ClothInformation> getClothInfo(File? image) async {
  ClothInformation clothInfoDetail = ClothInformation();

  final url = Uri.parse(url_base + 'predict');
  final request = http.MultipartRequest('POST', url);

  request.files.add(await http.MultipartFile.fromPath('image', image!.path));

  final response = await request.send();

  var responseBody = await response.stream.bytesToString();

  if (responseBody != null) {
    var rptaJson = json.decode(responseBody);

    clothInfoDetail.type = rptaJson['type']['name'];
    clothInfoDetail.season = rptaJson['season']['name'];
    clothInfoDetail.style = rptaJson['style']['name'];

    print("El color es: ${rptaJson['colors']['palette'][0]}");

    for(int i = 0; i < 1; i++) {
      var r = rptaJson['colors']['palette'][i][0];
      var g = rptaJson['colors']['palette'][i][1];
      var b = rptaJson['colors']['palette'][i][2];
      // var color = img.Color.fromRgb(r, g, b);

      var rgb = "${r},${g},${b})";
      var color = await getColorName(rgb);

      // clothInfoDetail.color = color.colorName;
      clothInfoDetail.color = color;
    }
  } else {
    print('Error al enviar la imagen. Código de estado: ${response.statusCode}');
  }

  return clothInfoDetail;
}

Future<List<OutfitResponse>> getOutfits(ClothRequest request) async {
  final url = Uri.parse(url_base + 'closet');
  final response = await http.post(url, headers: headers, body: jsonEncode(request));

  var outfits = List<OutfitResponse>.empty(growable: true);

  if (response.statusCode == 200) {
    var rptaJson = json.decode(response.body);

    // print(rptaJson);

    for (var outfit in rptaJson['outfits']) {
      var clothInfo = OutfitResponse();
      clothInfo.id = outfit['id'];
      clothInfo.name = outfit['name'];
      clothInfo.imgB64 = outfit['image'];
      outfits.add(clothInfo);
    }

  } else {
    // print(response.body);
    print('Error al obtener conjuntos. Código de estado: ${response.statusCode}');
  }

  return outfits;
}


Future<void> getHelloWorld() async {
  final url = Uri.parse(url_base);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Error al enviar la imagen. Código de estado: ${response.statusCode}');
  }
}