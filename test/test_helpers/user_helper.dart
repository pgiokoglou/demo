import "package:demo/dal/reqres_api.dart";
import "package:demo/models/user/data.dart";
import "package:demo/models/user/user.dart";
import "package:dio/dio.dart";

class UserHelper {
  static User get validUser => User(
        data: Data(
          id: 1,
          email: "george.bluth@reqres.in",
          firstName: "George",
          lastName: "Bluth",
          avatar: "https://reqres.in/img/faces/1-image.jpg",
        ),
      );

  static int get validUserId => validUser.data!.id!;

  UserHelper._();

  static DioException get invalidRequestDioExceptionForGetUser => DioException(
        response: Response<dynamic>(
          data: <String, String>{"message": "error message"},
          statusCode: 422,
          requestOptions: RequestOptions(path: ReqresApi.getUser),
        ),
        requestOptions: RequestOptions(path: ReqresApi.getUser),
        error: "Http status error [422]",
      );
}
