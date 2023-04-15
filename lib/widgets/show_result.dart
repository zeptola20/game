import 'package:flutter/material.dart';
import 'package:game/controllers/game_me_controller.dart';
import 'package:game/controllers/play_controller.dart';
import 'package:game/models/game_me_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ShowResult extends StatelessWidget {
  final int index;
  final _controller = Get.find<PlayController>();
  final _gameMeController = Get.find<GameMeController>();
  //for start again anď keeping information

  ShowResult({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    //check how win
    bool winMe = _gameMeController.results[index].winner ==
        _gameMeController.results[index].player1 as int;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            winMe ? 'You Win!' : 'You Lose',
            style: const TextStyle(
              fontFamily: "Wolf",
              fontSize: 80,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: Get.height / 7,
            width: Get.width,
            child: Obx(
              () => _controller.flag.value
                  ? Lottie.asset(
                      'assets/animation/7843-flixxo-coins.json',
                      repeat: false,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  _gameMeController.results[index] = Results(
                      id: _gameMeController.results[index].id,
                      opponentProfile:
                          _gameMeController.results[index].opponentProfile,
                      completed: false,
                      winner: null,
                      player1Won: 0,
                      player2Won: 0,
                      player1: _gameMeController.results[index].player1,
                      player2: _gameMeController.results[index].player2,
                      lastRound: LastRound(
                          id: _gameMeController.results[index].lastRound!.id,
                          player1Choice: null,
                          player2Choice: null));
                  _gameMeController.results[index].completed = false;
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: const Icon(
                    Icons.refresh,
                  ),
                ),
              ),
              if (winMe)
                GestureDetector(
                  onTap: () {
                    _controller.flag.value = !_controller.flag.value;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: const Text(
                      'Collect',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
