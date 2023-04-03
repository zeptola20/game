import 'package:json_annotation/json_annotation.dart';
part 'token_request_model.g.dart';

@JsonSerializable()
class TokenRequestModel {
  TokenRequestModel({
    this.email,
    this.password,
  });

  String? email;
  String? password;
  factory TokenRequestModel.fromJson(Map<String, dynamic> data) =>
      _$TokenRequestModelFromJson(data);
  Map<String, dynamic> toJson() => _$TokenRequestModelToJson(this);
}
