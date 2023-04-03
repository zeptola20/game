import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:game/models/profile_to_play_model.dart';

class ProfileToPlayRepository {
  ProfileToPlayModel? getResult;
  Future<Either<String, ProfileToPlayModel>> getSuggestCompetitors(
      String token) async {
    final dio = Dio();
    String apiUrl = 'https://atrovers.iran.liara.run/game/profile_to_play/';
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      // ignore: unused_local_variable
      final dialogs = await dio.get(apiUrl).then((value) {
        getResult = ProfileToPlayModel.fromJson(
          value.data as Map<String, dynamic>,
        );
      }).onError((error, stackTrace) {});

      return Right(getResult!);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
