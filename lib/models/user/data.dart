import "package:freezed_annotation/freezed_annotation.dart";

part "data.freezed.dart";
part "data.g.dart";

@freezed
class Data with _$Data {
  factory Data({
    int? id,
    String? email,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    String? avatar,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
