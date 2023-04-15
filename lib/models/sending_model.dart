class SendingModel {
  Map<String, dynamic> startGame(String opponent, Enum choice) {
    return {
      'msg_type': 1,
      'opponent': opponent,
      'choice': choice.index,
    };
  }

  Map<String, dynamic> sendResponse(String opponent, Enum choice, int gameId) {
    return {
      'msg_type': 5,
      'game_id': gameId,
      'opponent': opponent,
      'choice': choice.index,
    };
  }
}
