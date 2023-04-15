import 'package:flutter/material.dart';
import 'package:game/controllers/game_me_controller.dart';
import 'package:game/controllers/play_controller.dart';
import 'package:game/controllers/profile_to_play_controller.dart';
import 'package:game/widgets/game_card.dart';
import 'package:game/widgets/score.dart';
import 'package:get/get.dart';

class PlayPage extends StatelessWidget {
  final profileToPlayController = Get.put(ProfileToPlayController());
  final gameMeController = Get.put(GameMeController());

  PlayPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Score(),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            fontFamily: 'appFont',
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() => MaterialButton(
                      color:
                          !Get.find<PlayController>().selectSuggestButton.value
                              ? Colors.blue
                              : Colors.grey,
                      onPressed: () {
                        Get.find<PlayController>().selectSuggestButton.value =
                            false;
                        Get.find<PlayController>().isGameMe.value = true;
                        Get.find<GameMeController>().results.clear();
                        gameMeController.getCompetitorsList(
                            Get.find<GameMeController>().token.toString());
                      },
                      child: const Text('game me'))),
                  Obx(() => MaterialButton(
                      color:
                          Get.find<PlayController>().selectSuggestButton.value
                              ? Colors.blue
                              : Colors.grey,
                      onPressed: () {
                        Get.find<ProfileToPlayController>().results.clear();

                        Get.find<PlayController>().selectSuggestButton.value =
                            true;
                        Get.find<PlayController>().isGameMe.value = false;
                        profileToPlayController.getSuggestCompetitorsList(
                            gameMeController.token.toString());
                      },
                      child: const Text('suggest'))),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Stack(
                    children: [
                      GameCard(),
                    ],
                  )),
            ),
          ],
        ));
  }
}
