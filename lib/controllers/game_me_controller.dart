import 'package:game/models/game_me_model.dart';
import 'package:game/models/token_response_model.dart';
import 'package:game/repository/game_me_repository.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../repository/token_repository.dart';

class GameMeController extends GetxController {
  RxBool initailLoading = false.obs;
  RxList<Results> gameMeResults = RxList<Results>();
  final GameMeRepository _gameMeRepository = GameMeRepository();
  Rxn<TokenResponseModel> tokenModel = Rxn<TokenResponseModel>();
  final TokenRepository tokenRepository = TokenRepository();
  RxBool initApiError = false.obs;

  Future<void> getToken() async {
    initailLoading(true);
    final resultOrException = await tokenRepository.getToken();
    resultOrException.fold((l) {
      initApiError(true);
    }, (r) {
      tokenModel(r);
      getCompetitorsList(r.access!);
      print(r.access!);
      initApiError(false);
    });
  }

  Future<void> getCompetitorsList(String token) async {
    initailLoading(true);
    final resultOrException = await _gameMeRepository.getCompetitors(token);
    resultOrException.fold((l) {
      initApiError(true);
    }, (r) {
      gameMeResults(r.results);

      initailLoading(false);
      initApiError(false);
    });
  }
}
