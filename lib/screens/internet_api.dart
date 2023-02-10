import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_one/models/user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({super.key});

  @override
  State<RemoteApi> createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  late final Future<List<UserModel>> _allUser;
  @override
  void initState() {
    _allUser = getAllUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _allUser,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<UserModel> users = snapshot.data!;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(users[index].name),
                    subtitle: Text(users[index].email),
                    leading: CircleAvatar(
                      child: Text(users[index].id.toString()),
                    ),
                  );
                }));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else
            return Center(
              child: const CircularProgressIndicator(),
            );
        }),
      ),
    );
  }

  Future<List<UserModel>> getAllUser() async {
    try {
      String baseUrl = "https://jsonplaceholder.typicode.com";
      var response = await Dio().get('$baseUrl/users');

      var users = (response.data as List);
      List<UserModel> allUsers =
          users.map((user) => UserModel.fromJson(user)).toList();
      if (response.statusCode == 200) {
        return allUsers;
      }
      return [];
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }
}
