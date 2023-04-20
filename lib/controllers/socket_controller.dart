import 'package:flutter/foundation.dart';
import 'package:game/controllers/game_me_controller.dart';
import 'package:game/controllers/play_controller.dart';
import 'package:game/models/game_me_model.dart';
import 'package:game/models/sending_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class SocketController extends GetxController {
  late WebSocketChannel channelNew;
  RxString opponent = ''.obs;
  listenWebsocket() {
    channelNew = WebSocketChannel.connect(Uri.parse(
        'wss://atrovers.iran.liara.run/game_ws/${Get.find<GameMeController>().id}/'));

    channelNew.stream.listen((event) {
      print('event$event');
      if (Results.fromJson(jsonDecode(event)).msg_type == 1) {
        Get.find<GameMeController>()
            .results
            .insert(0, Results.fromJson(jsonDecode(event)));
      } else if (Results.fromJson(jsonDecode(event)).msg_type == 5) {}
    });
  }

//start game with some one
  startGame(Enum choice) {
    channelNew.sink
        .add(jsonEncode(SendingModel().startGame(opponent.value, choice)));
    Get.find<PlayController>().selectSuggestButton.value = false;
    Get.find<PlayController>().isGameMe.value = true;
    Get.find<GameMeController>()
        .getCompetitorsList(Get.find<GameMeController>().token.toString());
  }

//response to game
  sendResponse(Enum choice, int gameId) {
    try {
      channelNew.sink.add(jsonEncode(
          SendingModel().sendResponse(opponent.value, choice, gameId)));
    } catch (e) {
      debugPrint('error send: $e');
    }
  }

  cancelGame(int gameId) {
    try {
      channelNew.sink.add(jsonEncode({
        'msg_type': 2,
        'game_id': gameId,
      }));
    } catch (e) {
      debugPrint('cancel game error:$e');
    }
  }
}
