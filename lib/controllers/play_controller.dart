import 'package:flutter/material.dart';
import 'package:game/controllers/game_me_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PlayController extends GetxController {
  var opacity = false.obs;
  var flag = false.obs;
  var circleSelected1 = false.obs;
  var squareSelected1 = false.obs;
  var triangleSelected1 = false.obs;
  var selectSuggestButton = false.obs;
  RxBool endRound = false.obs;

  int currentCardIndex = 0;
  //when swiping between suggest and game me the index must start from first of list
  RxBool isGameMe = true.obs;
  @override
  void onInit() {
    Get.find<GameMeController>().getToken();
    // Get.find<ProfileToPlayController>().getToken();
    super.onInit();
  }

  onSwipe() {
    debugPrint('swiped');
  }

  onEnd() {
    //deleting card after finish game and swiper
    if (Get.find<GameMeController>()
        .results
        // ignore: curly_braces_in_flow_control_structures
        .isNotEmpty) if (Get.find<GameMeController>()
            .results[currentCardIndex]
            .completed ==
        // ignore: list_remove_unrelated_type
        true) {
      Get.find<GameMeController>().results.remove(currentCardIndex);
    }
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
