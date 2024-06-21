import "package:demo/models/user/user.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "users.freezed.dart";
part "users.g.dart";

@freezed
class Users with _$Users {
  factory Users({
    int? page,
    @JsonKey(name: "per_page") int? perPage,
    int? total,
    @JsonKey(name: "total_pages") int? totalPages,
    List<User>? data,
  }) = _Users;

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
}
