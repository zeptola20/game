import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:game/models/game_me_model.dart';

class GameMeRepository {
  GameMeModel? getResult;
  Future<Either<String, GameMeModel>> getCompetitors(String token) async {
    final dio = Dio();
    String apiUrl = 'https://atrovers.iran.liara.run/game/me/';
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      // ignore: unused_local_variable
      final dialogs = await dio.get(apiUrl).then((value) {
        getResult = GameMeModel.fromJson(
          value.data as Map<String, dynamic>,
        );
      }).onError((error, stackTrace) {
        debugPrint('error$error');
      });

      return Right(getResult!);
    } catch (e) {
      debugPrint('error$e');
      return Left(e.toString());
    }
  }
}
