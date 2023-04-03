import 'package:game/models/profile_to_play_model.dart';
import 'package:game/models/token_response_model.dart';
import 'package:game/repository/profile_me_repository.dart';
import 'package:game/repository/token_repository.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileToPlayController extends GetxController {
  RxBool initailLoading = false.obs;
  RxList<Results> profileToPlayResults = RxList<Results>();
  final ProfileToPlayRepository _profileToPlayRepository =
      ProfileToPlayRepository();
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
      getSuggestCompetitorsList(r.access!);

      initApiError(false);
    });
  }

  Future<void> getSuggestCompetitorsList(String token) async {
    initailLoading(true);
    final resultOrException =
        await _profileToPlayRepository.getSuggestCompetitors(token);
    resultOrException.fold((l) {
      initApiError(true);
    }, (r) {
      profileToPlayResults(r.results);

      initailLoading(false);
      initApiError(false);
    });
  }
}
