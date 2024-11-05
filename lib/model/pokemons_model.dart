class PokemonsModel {
  String name;
  String image;
  String type;
  int isFavorite;

  PokemonsModel(
      {required this.name,
      required this.image,
      required this.type,
      required this.isFavorite});

  Map<String, dynamic> toMap() {
    return {
      "name": name.toString(),
      "type": type.toString(),
      "image": image.toString(),
      "is_favorite": isFavorite
    };
  }
}
