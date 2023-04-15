// import 'package:json_annotation/json_annotation.dart';
// part 'game_me_model.g.dart';

// @JsonSerializable()
// class GameMeModel {
//   int? count;
//   String? next;
//   String? previous;
//   List<Results>? results;

//   GameMeModel({this.count, this.next, this.previous, this.results});

//   factory GameMeModel.fromJson(Map<String, dynamic> data) =>
//       _$GameMeModelFromJson(data);
//   Map<String, dynamic> toJson() => _$GameMeModelToJson(this);
// }

// @JsonSerializable()
// class Results {
//   int? id;
//   int? player1;
//   int? player2;
//   OpponentProfile? opponentProfile;
//   int? player1Won;
//   int? player2Won;
//   int? winner;
//   bool? completed;

//   Results(
//       {this.id,
//       this.player1,
//       this.player2,
//       this.opponentProfile,
//       this.player1Won,
//       this.player2Won,
//       this.winner,
//       this.completed});
//   factory Results.fromJson(Map<String, dynamic> data) =>
//       _$ResultsFromJson(data);
//   Map<String, dynamic> toJson() => _$ResultsToJson(this);
// }

// @JsonSerializable()
// class OpponentProfile {
//   int? id;
//   int? user;
//   String? image;
//   String? userName;
//   String? email;

//   OpponentProfile({this.id, this.user, this.image, this.userName, this.email});
//   factory OpponentProfile.fromJson(Map<String, dynamic> data) =>
//       _$OpponentProfileFromJson(data);
//   Map<String, dynamic> toJson() => _$OpponentProfileToJson(this);
// }

//************************
//we don't use this code because of bug OpponentProfile
//************************/
class GameMeModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  GameMeModel({this.count, this.next, this.previous, this.results});

  GameMeModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  // ignore: non_constant_identifier_names
  int? msg_type = 1;
  int? id;
  int? player1;
  int? player2;
  OpponentProfile? opponentProfile;
  int? player1Won;
  int? player2Won;
  int? winner;
  bool? completed;
  LastRound? lastRound;

  Results(
      {this.id,
      this.player1,
      this.player2,
      this.opponentProfile,
      this.player1Won,
      this.player2Won,
      this.winner,
      this.completed,
      this.lastRound});

  Results.fromJson(Map<String, dynamic> json) {
    msg_type = json['msg_type'];
    id = json['id'];
    player1 = json['player_1'];
    player2 = json['player_2'];
    opponentProfile = json['opponent_profile'] != null
        ? OpponentProfile.fromJson(json['opponent_profile'])
        : null;
    player1Won = json['player_1_won'];
    player2Won = json['player_2_won'];
    winner = json['winner'];
    completed = json['completed'];
    lastRound = json['last_round'] != null
        ? LastRound.fromJson(json['last_round'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg_type'] = msg_type;
    data['id'] = id;
    data['player_1'] = player1;
    data['player_2'] = player2;
    if (opponentProfile != null) {
      data['opponent_profile'] = opponentProfile!.toJson();
    }
    data['player_1_won'] = player1Won;
    data['player_2_won'] = player2Won;
    data['winner'] = winner;
    data['completed'] = completed;
    if (lastRound != null) {
      data['last_round'] = lastRound!.toJson();
    }
    return data;
  }
}

class OpponentProfile {
  int? id;
  int? user;
  String? image;
  String? userName;
  String? email;

  OpponentProfile({this.id, this.user, this.image, this.userName, this.email});

  OpponentProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    image = json['image'];
    userName = json['user_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['image'] = image;
    data['user_name'] = userName;
    data['email'] = email;
    return data;
  }
}

class LastRound {
  int? player1Choice;
  int? player2Choice;
  int? id;

  LastRound({this.player1Choice, this.player2Choice, this.id});

  LastRound.fromJson(Map<String, dynamic> json) {
    player1Choice = json['player_1_choice'];
    player2Choice = json['player_2_choice'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['player_1_choice'] = player1Choice;
    data['player_2_choice'] = player2Choice;
    data['id'] = id;
    return data;
  }
}
