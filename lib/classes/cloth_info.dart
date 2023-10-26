class ClothInformation {
  // datos de un conjunto
  String name;
  List<String> imagesUrls = [];

  // datos de una prenda
  String imgUrl;
  String type;
  String color;
  String season;
  String style;

  ClothInformation({
    this.name = "",
    this.imagesUrls = const [],

    this.imgUrl = "",
    this.type = "",
    this.color = "",
    this.season = "",
    this.style = "",
  });
}
