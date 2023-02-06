import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_one/models/car.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  @override
  Widget build(BuildContext context) {
    getCarsData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Json data'),
      ),
      body: Container(
        child: Center(
          child: Text('Json data'),
        ),
      ),
    );
  }

  getCarsData() async {
    String stringData = await DefaultAssetBundle.of(context)
        .loadString('assets/data/cars.json');

    var objectData = jsonDecode(stringData);
    var allData = (objectData as List);
    List<Car> carList =
        allData.map((carJson) => Car.fromJson(carJson)).toList();
    // debugPrint(allData[0]['car_model'][0]['model_name']);
    debugPrint(carList[2].carModel[0].modelName);
  }
}
