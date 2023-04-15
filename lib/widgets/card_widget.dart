import 'package:flutter/material.dart';
import 'package:game/controllers/game_me_controller.dart';
import 'package:game/controllers/play_controller.dart';
import 'package:game/controllers/profile_to_play_controller.dart';
import 'package:game/controllers/socket_controller.dart';
import 'package:game/widgets/option_icon.dart';
import 'package:game/widgets/show_result.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CardWidget extends StatelessWidget {
  final GameMeController gameController;
  final PlayController playController;
  final ProfileToPlayController profilePlayController;
  final int index;
  final bool isGameMe;

  CardWidget(
      {super.key,
      required this.gameController,
      required this.playController,
      required this.profilePlayController,
      required this.index,
      required this.isGameMe}) {
    if (isGameMe) {
      gameController.changeScore(
          gameController.results[index].player1Won as int,
          gameController.results[index].player2Won as int);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RotatedBox(
          quarterTurns: -2,
          child: OptionsIcon(
              isGameMe: isGameMe,
              profileToPlayController: profilePlayController,
              isTop: true,
              playController: playController,
              gameMeController: gameController,
              index: index),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: Get.height / 5),
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isGameMe
                      ? gameController
                                  .results[index].opponentProfile!.userName !=
                              null
                          ? gameController
                              .results[index].opponentProfile!.userName
                              .toString()
                          : 'null'
                      : profilePlayController.results[index].userName
                          .toString(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(index.toString()),
                Text(
                  isGameMe
                      ? gameController.results[index].opponentProfile!.email
                          .toString()
                      : profilePlayController.results[index].email.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (isGameMe)
                  MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      //delete card
                      gameController.results
                          .remove(gameController.results[index]);
                      Get.find<SocketController>().cancelGame(
                          gameController.results[index].player2.toString(),
                          gameController.results[index].id as int);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
        OptionsIcon(
            isGameMe: isGameMe,
            profileToPlayController: profilePlayController,
            isTop: false,
            playController: playController,
            gameMeController: gameController,
            index: index),

        // show result
        if (gameController.results[index].completed == true)
          ShowResult(index: index),
      ],
    );
  }
}
