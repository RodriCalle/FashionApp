class OutfitResponse {
  String id;
  String name;
  String urlImage;
  String imgB64;
  bool favorite = false;

  OutfitResponse({
    this.id = "",
    this.name = "",
    this.urlImage = "",
    this.imgB64 = "",
    this.favorite = false,
  });

  Map<String, dynamic> toMapSave() {
    return {
      'id': id,
      'name': name,
      'urlImage': urlImage,
      'favorite': favorite,
    };
  }

  factory OutfitResponse.fromMap(Map<String, dynamic> map) {
    return OutfitResponse(
      id: map['id'],
      name: map['name'],
      urlImage: map['urlImage'],
      imgB64: map['imgB64'] ?? '',
      favorite: map['favorite'] ?? true,
    );
  }
}
