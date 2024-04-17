class EbooksModel {
  final String name;
  final String description;
  final String author;
  final double rate;
  final double price;

  EbooksModel({
    required this.name,
    required this.description,
    required this.rate,
    required this.author,
    required this.price,
  });

  factory EbooksModel.fromJson(Map<String, dynamic> json) {
    return EbooksModel(
      name: json["name"] as String? ?? "",
      description: json["description"] as String? ?? "",
      author: json["author"] as String? ?? "",
      rate: json["rate"] as double? ?? 0.0,
      price: json["price"] as double? ?? 0.0,
    );
  }
}