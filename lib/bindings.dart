import 'package:game/controllers/socket_controller.dart';
import 'package:game/controllers/token_controller.dart';
import 'package:game/controllers/play_controller.dart';
import 'package:get/get.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<SocketController>(SocketController());
    // Get.lazyPut(() => GameMeController());
    // Get.lazyPut(() => ProfileToPlayController());
    Get.lazyPut(() => TokenController());
    Get.lazyPut(() => PlayController());
    // Get.lazyPut(() => SocketController());
  }
}
