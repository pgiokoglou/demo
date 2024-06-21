import "package:demo/dal/reqres_api.dart";
import "package:dio/dio.dart" hide Headers;
import "package:retrofit/retrofit.dart";

part "reqres_client.g.dart";

const Map<String, dynamic> jsonHeader = <String, dynamic>{
  "Content-Type": "application/json",
};

@RestApi()
abstract class ReqresClient {
  static const String id = "id";

  factory ReqresClient(Dio dio) = _ReqresClient;

  @GET(ReqresApi.getUser)
  @Headers(jsonHeader)
  Future<dynamic> getUser(@Path(id) int id);

  @GET(ReqresApi.getUsers)
  @Headers(jsonHeader)
  Future<dynamic> getUsers();
}
