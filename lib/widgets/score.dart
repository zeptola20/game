import 'package:flutter/material.dart';
import 'package:game/controllers/play_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controllers/game_me_controller.dart';

class Score extends StatelessWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey[100],
              backgroundImage: NetworkImage(Get.find<GameMeController>()
                      .results
                      .isEmpty
                  ? 'https://xsgames.co/randomusers/avatar.php?g=male'
                  : Get.find<GameMeController>().results[0].opponentProfile !=
                          null
                      ? Get.find<GameMeController>()
                          .results[0]
                          .opponentProfile!
                          .image
                          .toString()
                      : 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png'),
            )),
        GetBuilder<GameMeController>(
          id: 'score',
          builder: (_) {
            return Text(Get.find<PlayController>().isGameMe.value
                ? Get.find<GameMeController>().player1Won.toString()
                : '');
          },
        ),
        const Text('-'),
        GetBuilder<GameMeController>(
          id: 'score',
          builder: (_) {
            return Text(Get.find<PlayController>().isGameMe.value
                ? Get.find<GameMeController>().player2Won.toString()
                : '');
          },
        ),
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 23,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey[100],
              backgroundImage: const NetworkImage(
                  'https://xsgames.co/randomusers/avatar.php?g=female'),
            ),
          ),
        ),
      ],
    );
  }
}
