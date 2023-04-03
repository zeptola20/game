import 'package:json_annotation/json_annotation.dart';
part 'game_me_model.g.dart';

@JsonSerializable()
class GameMeModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  GameMeModel({this.count, this.next, this.previous, this.results});

  factory GameMeModel.fromJson(Map<String, dynamic> data) =>
      _$GameMeModelFromJson(data);
  Map<String, dynamic> toJson() => _$GameMeModelToJson(this);
}

@JsonSerializable()
class Results {
  int? id;
  int? player1;
  int? player2;
  OpponentProfile? opponentProfile;
  int? player1Won;
  int? player2Won;
  int? winner;
  bool? completed;

  Results(
      {this.id,
      this.player1,
      this.player2,
      this.opponentProfile,
      this.player1Won,
      this.player2Won,
      this.winner,
      this.completed});
  factory Results.fromJson(Map<String, dynamic> data) =>
      _$ResultsFromJson(data);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

@JsonSerializable()
class OpponentProfile {
  int? id;
  int? user;
  String? image;
  String? userName;
  String? email;

  OpponentProfile({this.id, this.user, this.image, this.userName, this.email});
  factory OpponentProfile.fromJson(Map<String, dynamic> data) =>
      _$OpponentProfileFromJson(data);
  Map<String, dynamic> toJson() => _$OpponentProfileToJson(this);
}
