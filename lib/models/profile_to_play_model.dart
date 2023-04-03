import 'package:json_annotation/json_annotation.dart';
part 'profile_to_play_model.g.dart';

@JsonSerializable()
class ProfileToPlayModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  ProfileToPlayModel({this.count, this.next, this.previous, this.results});

  factory ProfileToPlayModel.fromJson(Map<String, dynamic> data) =>
      _$ProfileToPlayModelFromJson(data);
  Map<String, dynamic> toJson() => _$ProfileToPlayModelToJson(this);
}

@JsonSerializable()
class Results {
  int? id;
  int? user;
  String? image;
  String? userName;
  String? email;

  Results({this.id, this.user, this.image, this.userName, this.email});

  factory Results.fromJson(Map<String, dynamic> data) =>
      _$ResultsFromJson(data);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
