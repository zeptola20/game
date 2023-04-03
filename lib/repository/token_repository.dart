import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:game/models/token_request_model.dart';
import 'package:game/models/token_response_model.dart';

class TokenRepository {
  int? myId;
  TokenResponseModel getDialogResult = TokenResponseModel();
  Future<Either<String, TokenResponseModel>> getToken() async {
    final dio = Dio();
    String apiUrl = 'https://atrovers.iran.liara.run/account/token/';
    try {
      // ignore: unused_local_variable
      final dialogs = await dio
          .post(apiUrl,
              data: TokenRequestModel(
                      email: "sam@gmail.com", password: "12345678")
                  .toJson())
          .then((value) {
        getDialogResult =
            TokenResponseModel.fromJson(value.data as Map<String, dynamic>);
        myId = getDialogResult.id;
      });

      return Right(getDialogResult);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
