// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

import 'carModel.dart';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  Car({
    required this.carName,
    required this.carYear,
    required this.country,
    required this.carModel,
  });

  final String carName;
  final int carYear;
  final String country;
  final List<CarModel> carModel;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        carName: json["car_name"],
        carYear: json["car_year"],
        country: json["country"],
        carModel: List<CarModel>.from(
            json["car_model"].map((x) => CarModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "car_name": carName,
        "car_year": carYear,
        "country": country,
        "car_model": List<dynamic>.from(carModel.map((x) => x.toJson())),
      };
}
