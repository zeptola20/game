import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:game/controllers/game_me_controller.dart';
import 'package:game/controllers/play_controller.dart';
import 'package:game/controllers/profile_to_play_controller.dart';
import 'package:game/widgets/card_widget.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class GameCard extends StatelessWidget {
  final gameController = Get.find<GameMeController>();
  final playController = Get.find<PlayController>();
  final profilePlayController = Get.find<ProfileToPlayController>();

  GameCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (gameController.listEmpty.value &&
          playController.isGameMe.value == true) {
        return const Center(
          child: Text('there is no card for showing'),
        );
      } else if (gameController.results.isEmpty &&
          playController.isGameMe.value == true &&
          gameController.listEmpty.value == false) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (gameController.results.isNotEmpty &&
          playController.isGameMe.value == true) {
        return CardSwiper(
          key: UniqueKey(),
          numberOfCardsDisplayed: 1,
          // controller: controller,
          padding: const EdgeInsets.all(24.0),
          onSwipe: Get.find<PlayController>().onSwipe(),
          onEnd: Get.find<PlayController>().onEnd(),
          cardsCount: gameController.results.length,
          cardBuilder: (BuildContext context, int index) {
            bool checkMeP1 =
                gameController.results[index].player1 == gameController.id;
            playController.currentCardIndex = index;
            return Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(gameController
                            .results[index].opponentProfile!.image
                            .toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: CardWidget(
                        gameController: gameController,
                        playController: playController,
                        profilePlayController: profilePlayController,
                        index: index,
                        isGameMe: playController.isGameMe.value)),
                //waiting for opponent chose
                Obx(() {
                  //if opponent choose is null show the message
                  if (checkMeP1) {
                    return gameController
                                    .results[index].lastRound!.player2Choice ==
                                null &&
                            gameController
                                    .results[index].lastRound!.player1Choice !=
                                null &&
                            playController.endRound.value == false
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade100,
                              ),
                              padding: const EdgeInsets.all(20),
                              child: const Text(
                                  'waiting for opponent play\'s turn'),
                            ),
                          )
                        : const SizedBox();
                  } else {
                    return gameController
                                    .results[index].lastRound!.player1Choice ==
                                null &&
                            gameController
                                    .results[index].lastRound!.player2Choice !=
                                null &&
                            playController.endRound.value == false
                        ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade100,
                              ),
                              padding: const EdgeInsets.all(20),
                              child: const Text(
                                  'waiting for opponent play\'s turn'),
                            ),
                          )
                        : const SizedBox();
                  }
                })
              ],
            );
          },
        );
      } else if (profilePlayController.results.isEmpty &&
          playController.isGameMe.value == false) {
        return const Center(child: CircularProgressIndicator());
      } else if (profilePlayController.results.isNotEmpty &&
          playController.isGameMe.value == false) {
        return CardSwiper(
          key: UniqueKey(),
          numberOfCardsDisplayed: 1,
          // controller: controller,
          padding: const EdgeInsets.all(24.0),
          onSwipe: Get.find<PlayController>().onSwipe(),
          onEnd: Get.find<PlayController>().onEnd(),
          cardsCount: profilePlayController.results.length,
          cardBuilder: (BuildContext context, int index) {
            playController.currentCardIndex = index;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      profilePlayController.results[index].image.toString()),
                  fit: BoxFit.cover,
                ),
              ),
              child: CardWidget(
                  gameController: gameController,
                  playController: playController,
                  profilePlayController: profilePlayController,
                  index: index,
                  isGameMe: playController.isGameMe.value),
            );
          },
        );
      }
      return const SizedBox();
    });
  }
}
