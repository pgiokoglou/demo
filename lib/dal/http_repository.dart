import "package:demo/dal/reqres_api.dart";
import "package:demo/dal/reqres_client.dart";
import "package:demo/models/user/data.dart";
import "package:demo/models/user/user.dart";
import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:mockito/annotations.dart";

@GenerateMocks(<Type>[ReqresClient])
class HttpRepository {
  @protected
  late ReqresClient client;

  @protected
  late Dio dio;

  HttpRepository() {
    dio = Dio(BaseOptions(baseUrl: ReqresApi.baseUrl));
    client = ReqresClient(dio);
  }

  Future<User> getUser(int id) async => User.fromJson(await client.getUser(id));

  Future<List<User>> getUsers() async {
    final Map<String, dynamic> map = await client.getUsers() as Map<String, dynamic>;
    final List<dynamic> usersJson = (map["data"]) as List<dynamic>;

    // ignore: always_specify_types, unnecessary_lambdas
    return List<User>.from(usersJson.map((e) => User(data: Data.fromJson(e)))).toList();
  }
}
