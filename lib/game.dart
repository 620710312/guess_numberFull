import 'dart:math';

class Game {
  static const defaultMaxRandom = 100;
  int? answer;
  int _guessCount = 0;
  static final List<int> guessCountList = [];

  Game() {
    var r = Random();
    answer = r.nextInt(100) + 1;
  }

  int get guessCount {
    return _guessCount;
  }

  void addCountList() {
    guessCountList.add(_guessCount);
  }

  int doGuess(int num) {
    _guessCount++;
    if (num > answer!) {
      return 1;
    } else if (num < answer!) {
      return -1;
    } else {
      return 0;
    }
  }
}
