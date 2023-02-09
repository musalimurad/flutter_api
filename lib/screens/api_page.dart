import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_one/models/car.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  String _title = "Json data";
  late final Future<List<Car>> _allCars;

  @override
  void initState() {
    _allCars = getAllCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _title = "api json data";
          });
        },
        child: Text('click'),
      ),
      body: FutureBuilder(
        future: _allCars,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<Car> cars = snapshot.data!;

            return ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                Car car = cars[index];
                return ListTile(
                  title: Text(car.carName),
                  subtitle: Text(car.country),
                  leading: CircleAvatar(
                      radius: 59.0,
                      child: Text(car.carModel[0].price.toString())),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  Future<List<Car>> getAllCars() async {
    await Future.delayed(Duration(seconds: 5));
    String stringData = await DefaultAssetBundle.of(context)
        .loadString('assets/data/cars.json');
    var objectData = jsonDecode(stringData);

    var allData = (objectData as List);
    List<Car> carList = allData
        .map((carJson) => Car.fromJson(carJson))
        .toList(); // debugPrint(allData[0]['car_model'][0]['model_name']);
    // debugPrint(carList[2].carModel[0].modelName);
    return carList;
  }
}
