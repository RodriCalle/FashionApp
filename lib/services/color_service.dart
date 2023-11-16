import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

var url_base = 'https://www.thecolorapi.com/';

Future<String> getColorName(String rgb) async {
  String name = "Black";

  var colorUrl = "${url_base}id?format=json&rgb=rgb(${rgb})";
  final url = Uri.parse(colorUrl);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var rptaJson = json.decode(response.body);
    name = rptaJson['name']['value'];
    // print(response.body);
  } else {
    print('Error al enviar la imagen. Código de estado: ${response.statusCode}');
  }

  return name;
}