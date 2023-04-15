import 'package:flutter/material.dart';
import 'package:game/models/game_me_model.dart';
import 'package:game/models/token_response_model.dart';
import 'package:game/repository/game_me_repository.dart';
import 'package:get/get.dart';

import '/repository/token_repository.dart';

enum OptionsItem { rock, paper, scissors }

class GameMeController extends GetxController {
  RxBool initailLoading = false.obs;
  RxList<Results> results = RxList<Results>();
  final GameMeRepository _gameMeRepository = GameMeRepository();
  Rxn<TokenResponseModel> tokenModel = Rxn<TokenResponseModel>();
  final TokenRepository tokenRepository = TokenRepository();
  RxBool initApiError = false.obs;
  int player1Won = 0;
  int player2Won = 0;
  int? id;
  String? token;
  RxBool cancelChooseEndRound = false.obs;
  RxInt resultRoundWinner = 4.obs;
  RxBool listEmpty = false.obs;
  changeScore(int player1, int player2) {
    player1Won = player1;
    player2Won = player2;
    update();
  }

  Future<void> getToken() async {
    initailLoading(true);
    final resultOrException = await tokenRepository.getToken();
    resultOrException.fold((l) {
      initApiError(true);
    }, (r) {
      tokenModel(r);
      debugPrint(r.toString());
      getCompetitorsList(r.access!);
      id = r.id;

      token = r.access!;

      debugPrint('token: $token');
      debugPrint('id:$id');

      initApiError(false);
    });
  }

  Future<void> getCompetitorsList(String token) async {
    listEmpty.value = false;

    initailLoading(true);
    final resultOrException = await _gameMeRepository.getCompetitors(token);
    resultOrException.fold((l) {
      l.printError();
      initApiError(true);
    }, (r) {
      results.value = r.results as List<Results>;
      if (r.results!.isEmpty) {
        listEmpty.value = true;
      }

      initailLoading(false);
      initApiError(false);
    });
  }

  int winnerRound(int player1choose, int player2choose) {
    if (player1choose == 0 && player2choose == 1) {
      return player2choose;
    } else if (player1choose == 0 && player2choose == 2) {
      return player1choose;
    } else if (player1choose == 1 && player2choose == 2) {
      return player2choose;
    } else if (player1choose == 1 && player2choose == 0) {
      return player2choose;
    } else if (player1choose == 2 && player2choose == 0) {
      return player1choose;
    } else if (player1choose == 2 && player2choose == 1) {
      return player2choose;
    }
    return 3; //same each other
  }
}
