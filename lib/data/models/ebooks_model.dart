class EbooksModel {
  final String id;
  final String name;
  final String description;
  final String author;
  final String image;
  final num rate;
  final num price;

  EbooksModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rate,
    required this.author,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    "_uuid": id,
    "name": name,
    "description": description,
    "author": author,
    "image": image,
    "rate": rate,
    "price": price,
  };

  factory EbooksModel.fromJson(Map<String, dynamic> json) {
    return EbooksModel(
      id: json["_uuid"] as String? ?? "",
      name: json["name"] as String? ?? "",
      description: json["description"] as String? ?? "",
      author: json["author"] as String? ?? "",
      image: json["image"] as String? ?? "",
      rate: json["rate"] as num? ?? 0.0,
      price: json["price"] as num? ?? 0.0,
    );
  }
}