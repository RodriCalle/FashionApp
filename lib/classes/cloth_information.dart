class ClothInformation {
  late String id = "";
  late String urlImage = "";

  late String type = "";
  late String color = "";
  late String season = "";
  late String style = "";

  bool favorite = false;

  ClothInformation();

  ClothInformation.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    urlImage = map['urlImage'];
    type = map['type'];
    color = map['color'];
    season = map['season'];
    style = map['style'];
    favorite = map['favorite'] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'urlImage': urlImage,
      'type': type,
      'color': color,
      'season': season,
      'style': style,
      'favorite': favorite,
    };
  }
}
