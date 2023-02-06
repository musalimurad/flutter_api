class CarModel {
  CarModel({
    required this.modelName,
    required this.price,
    required this.isNew,
  });

  final String modelName;
  final int price;
  final bool isNew;

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        modelName: json["model_name"],
        price: json["price"],
        isNew: json["isNew"],
      );

  Map<String, dynamic> toJson() => {
        "model_name": modelName,
        "price": price,
        "isNew": isNew,
      };
}
