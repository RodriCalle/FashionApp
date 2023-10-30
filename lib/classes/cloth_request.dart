class ClothRequest {
  String type = "T-Shirt";
  String color = "Blue";
  String season = "Summer";
  String style = "Casual";

  String temperature = "25";
  String sex = "Man";

  ClothRequest();

  Map<String, dynamic> toJson() {
    return {
      'style': style,
      'color': color,
      'type': type,
      'temperature': temperature,
      'sex': sex,
      'season': season
    };
  }
}