import 'package:json_annotation/json_annotation.dart';
part 'token_response_model.g.dart';

@JsonSerializable()
class TokenResponseModel {
  TokenResponseModel({
    this.refresh,
    this.access,
    this.id,
    this.email,
    this.code,
    this.done,
  });

  String? refresh;
  String? access;
  int? id;
  String? email;
  String? code;
  bool? done;
  factory TokenResponseModel.fromJson(Map<String, dynamic> data) =>
      _$TokenResponseModelFromJson(data);
  Map<String, dynamic> toJson() => _$TokenResponseModelToJson(this);
}
