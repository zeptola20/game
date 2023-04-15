import 'package:flutter/material.dart';
import 'package:game/controllers/game_me_controller.dart';
import 'package:game/controllers/play_controller.dart';
import 'package:game/controllers/profile_to_play_controller.dart';
import 'package:game/controllers/socket_controller.dart';
import 'package:game/models/game_me_model.dart';
import 'package:get/get.dart';

class OptionsIcon extends StatefulWidget {
  final PlayController playController;
  final bool isTop, isGameMe;
  final int index;
  final GameMeController gameMeController;
  final ProfileToPlayController profileToPlayController;

  const OptionsIcon(
      {super.key,
      required this.playController,
      required this.isTop,
      required this.index,
      required this.gameMeController,
      required this.profileToPlayController,
      required this.isGameMe});

  @override
  State<OptionsIcon> createState() => _OptionsIconState();
}

class _OptionsIconState extends State<OptionsIcon> {
  final SocketController _socketController = SocketController();
  @override
  void initState() {
    super.initState();
    _socketController.listenWebsocket();
  }

//stop touch 2 times
  bool firstTouch = true;
//send item we select
  _selectSendItem(OptionsItem item, int gameId, String opponent) {
    //if both not choose
    if (widget.gameMeController.results[widget.index].lastRound!
                .player1Choice ==
            null &&
        widget.gameMeController.results[widget.index].lastRound!
                .player2Choice ==
            null) {
      // detect which is me and update list
      if (widget.gameMeController.results[widget.index].player1 ==
          widget.gameMeController.id) {
        widget.gameMeController.results[widget.index].lastRound!.player1Choice =
            item.index;
      } else {
        widget.gameMeController.results[widget.index].lastRound!.player2Choice =
            item.index;
      }
      //if both choose
    } else if (widget.gameMeController.results[widget.index].lastRound!
                .player1Choice !=
            null &&
        widget.gameMeController.results[widget.index].lastRound!
                .player2Choice !=
            null) {
      Get.find<PlayController>().endRound.value =
          true; //not show message waite for .. when round ends
    }
    //update list according to choice
//player2 choose
    else if (widget
            .gameMeController.results[widget.index].lastRound!.player1Choice !=
        null) {
      widget.gameMeController.results[widget.index].lastRound!.player2Choice =
          item.index;
      //player1 choose
    } else if (widget
            .gameMeController.results[widget.index].lastRound!.player2Choice !=
        null) {
      widget.gameMeController.results[widget.index].lastRound!.player1Choice =
          item.index;
    }
    //sending choose
    widget.playController.isGameMe.value
        ? _socketController.sendResponse(opponent, OptionsItem.rock, gameId)
        : _socketController.startGame(opponent, item);
    if (Get.find<PlayController>().endRound.value) {
      widget.gameMeController.resultRoundWinner.value = widget.gameMeController
          .winnerRound(
              widget.gameMeController.results[widget.index].lastRound!
                  .player1Choice as int,
              widget.gameMeController.results[widget.index].lastRound!
                  .player2Choice as int);
    }
//detect winner round
    if (widget.gameMeController.resultRoundWinner.value == 3) {
      // equal
      Future.delayed(const Duration(milliseconds: 1000)).then(
          (value) => widget.gameMeController.cancelChooseEndRound.value = true);
      // ignore: unnecessary_null_comparison
    } else if (widget.gameMeController.resultRoundWinner.value == null) {
    } else {
      //player1 win
      if (widget.gameMeController.results[widget.index].lastRound!
              .player1Choice ==
          widget.gameMeController.resultRoundWinner.value) {
        // change score
        widget.gameMeController.changeScore(
            int.parse(widget.gameMeController.results[widget.index].player1Won
                    .toString()) +
                1,
            widget.gameMeController.results[widget.index].player2Won as int);
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          Future.delayed(const Duration(milliseconds: 1000)).then((value) =>
              widget.gameMeController.cancelChooseEndRound.value = true);
        });
        //player2 win
      } else if (widget.gameMeController.results[widget.index].lastRound!
              .player2Choice ==
          widget.gameMeController.resultRoundWinner.value) {
//change score
        widget.gameMeController.changeScore(
            int.parse(widget.gameMeController.results[widget.index].player2Won
                    .toString()) +
                1,
            widget.gameMeController.results[widget.index].player1Won as int);
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          Future.delayed(const Duration(milliseconds: 1000)).then((value) =>
              widget.gameMeController.cancelChooseEndRound.value = true);
        });
      } else {
        //for player lose
        Future.delayed(const Duration(milliseconds: 1000)).then((value) =>
            widget.gameMeController.cancelChooseEndRound.value = true);
      }
      //for equal time
      Future.delayed(const Duration(milliseconds: 1000)).then(
          (value) => widget.gameMeController.cancelChooseEndRound.value = true);
    }
  }

  @override
  Widget build(BuildContext context) {
//check winner round

    // ignore: prefer_typing_uninitialized_variables
    var temp1;
    late bool play2Enemy;
    var temp = Rx(temp1);
    if (widget.isGameMe) {
      if (widget.gameMeController.results[widget.index].player2 ==
          widget.gameMeController.results[widget.index].opponentProfile!.user) {
        play2Enemy = true;
      } else {
        play2Enemy = false;
      }
    }

    if (widget.isGameMe) {
      if (widget.isTop) {
        if (play2Enemy) {
          temp.value = widget
              .gameMeController.results[widget.index].lastRound!.player2Choice;
        } else {
          temp.value = widget
              .gameMeController.results[widget.index].lastRound!.player1Choice;
        }
      } else {
        if (play2Enemy) {
          temp.value = widget
              .gameMeController.results[widget.index].lastRound!.player1Choice;
        } else {
          temp.value = widget
              .gameMeController.results[widget.index].lastRound!.player2Choice;
        }
      }
    } else if (!widget.isGameMe) {
      var s = Results(
          completed: false,
          id: widget.profileToPlayController.results[widget.index].id,
          opponentProfile: OpponentProfile(
            email: widget.profileToPlayController.results[widget.index].email,
            user: int.parse(widget
                .profileToPlayController.results[widget.index].user
                .toString()),
            image: widget.profileToPlayController.results[widget.index].image,
          ),
          lastRound: LastRound(
              id: 1,
              player2Choice: null,
              player1Choice:
                  widget.profileToPlayController.profileChoseFirst != null
                      ? widget.profileToPlayController.profileChoseFirst!.value
                      : null));
      if (!widget.isTop) {
        temp.value = s.lastRound!.player1Choice;
      }
    }

    return Stack(
      children: [
        RockWidget(temp),
        PaperWidget(temp),
        ScissorsWidget(temp),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  GestureDetector ScissorsWidget(Rx<dynamic> temp) {
    return GestureDetector(
      onTap: !widget.isTop
          ? () {
              if (firstTouch) {
                if (widget.playController.squareSelected1.value == true ||
                    widget.playController.circleSelected1.value == true) {
                } else {
                  widget.playController.triangleSelected1.value =
                      !widget.playController.triangleSelected1.value;
                }
                if (widget.playController.isGameMe.value &&
                    temp.value == null) {
                  _selectSendItem(
                      OptionsItem.scissors,
                      widget.gameMeController.results[widget.index].id as int,
                      widget.gameMeController.results[widget.index].player2
                          .toString());
                  temp.value = OptionsItem.scissors.index;
                } else if (widget.playController.isGameMe.value == false &&
                    temp.value == null) {
                  _selectSendItem(
                      OptionsItem.scissors,
                      widget.profileToPlayController.results[widget.index].id
                          as int,
                      widget.profileToPlayController.results[widget.index].user
                          .toString());
                  temp.value = OptionsItem.scissors.index;
                }
              } else if (!firstTouch) {
                widget.playController.triangleSelected1.value =
                    !widget.playController.triangleSelected1.value;
                firstTouch = true;
              }
            }
          : null,
      child: Obx(() {
        return AnimatedAlign(
          alignment: temp.value == OptionsItem.scissors.index &&
                  widget.gameMeController.cancelChooseEndRound.value == false
              ? Alignment.center
              : Alignment.bottomRight,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.fastOutSlowIn,
          child: RotatedBox(
            quarterTurns: widget.isTop ? -2 : 0,
            child: CustomPaint(
              painter: TrianglePainter(
                strokeColor: Colors.grey.shade300,
                strokeWidth: 10,
                paintingStyle: PaintingStyle.fill,
              ),
              child: Container(
                alignment: Alignment.bottomCenter,
                width: 80,
                height: 80,
                child: const Text(
                  '✌️',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ignore: non_constant_identifier_names
  GestureDetector PaperWidget(Rx<dynamic> temp) {
    return GestureDetector(
      onTap: !widget.isTop
          ? () {
              if (firstTouch) {
                if (widget.playController.circleSelected1.value == true ||
                    widget.playController.triangleSelected1.value == true) {
                } else {
                  widget.playController.squareSelected1.value =
                      !widget.playController.squareSelected1.value;
                }
                if (widget.playController.isGameMe.value &&
                    temp.value == null) {
                  _selectSendItem(
                      OptionsItem.paper,
                      widget.gameMeController.results[widget.index].id as int,
                      widget.gameMeController.results[widget.index].player2
                          .toString());
                  temp.value = OptionsItem.paper.index;
                } else if (widget.playController.isGameMe.value == false &&
                    temp.value == null) {
                  _selectSendItem(
                      OptionsItem.paper,
                      widget.profileToPlayController.results[widget.index].id
                          as int,
                      widget.profileToPlayController.results[widget.index].user
                          .toString());
                  temp.value = OptionsItem.paper.index;
                }
              } else if (!firstTouch) {
                widget.playController.squareSelected1.value =
                    !widget.playController.squareSelected1.value;
                firstTouch = true;
              }
            }
          : null,
      child: Obx(
        () {
          return AnimatedAlign(
            alignment: temp.value == OptionsItem.paper.index &&
                    widget.gameMeController.cancelChooseEndRound.value == false
                ? Alignment.center
                : Alignment.bottomCenter,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.fastOutSlowIn,
            child: RotatedBox(
              quarterTurns: widget.isTop ? -2 : 0,
              child: Container(
                alignment: Alignment.center,
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                child: const Text(
                  '✋',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  GestureDetector RockWidget(Rx<dynamic> temp) {
    return GestureDetector(
      onTap: !widget.isTop //disable select top items
          ? () {
              if (firstTouch) {
                //select one item each time
                if (widget.playController.squareSelected1.value == true ||
                    widget.playController.triangleSelected1.value == true) {
                } else {
                  widget.playController.circleSelected1.value =
                      !widget.playController.circleSelected1.value;
                  if (widget.playController.isGameMe.value &&
                      temp.value == null) {
                    //when we select option in profile to play
                    _selectSendItem(
                        OptionsItem.rock,
                        widget.gameMeController.results[widget.index].id as int,
                        widget.gameMeController.results[widget.index].player2
                            .toString());
                    temp.value = OptionsItem.rock.index;
                  } else if (widget.playController.isGameMe.value == false &&
                      temp.value == null) {
                    _selectSendItem(
                        OptionsItem.rock,
                        widget.profileToPlayController.results[widget.index].id
                            as int,
                        widget
                            .profileToPlayController.results[widget.index].user
                            .toString());
                    temp.value = OptionsItem.rock.index;
                  }
                }
                firstTouch = false;
              } else if (!firstTouch) {
                widget.playController.circleSelected1.value =
                    !widget.playController.circleSelected1.value;
                firstTouch = true;
              }
            }
          : null,
      child: Obx(
        () {
          return AnimatedAlign(
            alignment: temp.value == OptionsItem.rock.index &&
                    widget.gameMeController.cancelChooseEndRound.value == false
                ? Alignment.center
                : Alignment.bottomLeft,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.fastOutSlowIn,
            child: RotatedBox(
              quarterTurns: widget.isTop ? -2 : 0,
              child: Container(
                alignment: Alignment.center,
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                ),
                child: const Text(
                  '✊',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
