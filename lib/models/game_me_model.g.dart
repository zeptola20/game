// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'game_me_model.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// GameMeModel _$GameMeModelFromJson(Map<String, dynamic> json) => GameMeModel(
//       count: json['count'] as int?,
//       next: json['next'] as String?,
//       previous: json['previous'] as String?,
//       results: (json['results'] as List<dynamic>?)
//           ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );

// Map<String, dynamic> _$GameMeModelToJson(GameMeModel instance) =>
//     <String, dynamic>{
//       'count': instance.count,
//       'next': instance.next,
//       'previous': instance.previous,
//       'results': instance.results,
//     };

// Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
//       id: json['id'] as int?,
//       player1: json['player1'] as int?,
//       player2: json['player2'] as int?,
//       opponentProfile: json['opponentProfile'] == null
//           ? null
//           : OpponentProfile.fromJson(
//               json['opponentProfile'] as Map<String, dynamic>),
//       player1Won: json['player1Won'] as int?,
//       player2Won: json['player2Won'] as int?,
//       winner: json['winner'] as int?,
//       completed: json['completed'] as bool?,
//     );

// Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
//       'id': instance.id,
//       'player1': instance.player1,
//       'player2': instance.player2,
//       'opponentProfile': instance.opponentProfile,
//       'player1Won': instance.player1Won,
//       'player2Won': instance.player2Won,
//       'winner': instance.winner,
//       'completed': instance.completed,
//     };

// OpponentProfile _$OpponentProfileFromJson(Map<String, dynamic> json) =>
//     OpponentProfile(
//       id: json['id'] as int?,
//       user: json['user'] as int?,
//       image: json['image'] as String?,
//       userName: json['userName'] as String?,
//       email: json['email'] as String?,
//     );

// Map<String, dynamic> _$OpponentProfileToJson(OpponentProfile instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'user': instance.user,
//       'image': instance.image,
//       'userName': instance.userName,
//       'email': instance.email,
//     };
