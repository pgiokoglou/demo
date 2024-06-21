import "package:demo/dal/reqres_api.dart";
import "package:demo/dal/reqres_client.dart";
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
}
