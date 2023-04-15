import 'package:flutter/foundation.dart';
import 'package:game/models/token_response_model.dart';
import 'package:game/repository/token_repository.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TokenController extends GetxController {
  int? id;

  RxBool initailLoading = false.obs;

  Rxn<TokenResponseModel> tokenModel = Rxn<TokenResponseModel>();
  final TokenRepository tokenRepository = TokenRepository();
  RxBool initApiError = false.obs;

  Future<void> getToken() async {
    initailLoading(true);
    final resultOrException = await tokenRepository.getToken();
    resultOrException.fold((l) {
      initApiError(true);
    }, (r) {
      id = r.id;
      debugPrint(r.access);
      tokenModel(r);

      initApiError(false);
    });
  }
}
