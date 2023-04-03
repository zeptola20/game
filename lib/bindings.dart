import 'package:game/controllers/game_me_controller.dart';
import 'package:game/controllers/profile_to_play_controller.dart';
import 'package:game/controllers/token_controller.dart';
import 'package:game/controllers/play_controller.dart';
import 'package:get/get.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameMeController());
    Get.lazyPut(() => ProfileToPlayController());
    Get.lazyPut(() => TokenController());
    Get.lazyPut(() => PlayController());
  }
}
