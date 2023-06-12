import 'package:mobx/mobx.dart';

part 'TicTacToeStore.g.dart';

class TicTacToeStore = _TicTacToeStore with _$TicTacToeStore;

abstract class _TicTacToeStore with Store {
  @observable
  ObservableList<String> board = ObservableList.of(List.filled(9, ''));

  @observable
  String currentPlayer = 'X';

  // @computed
  // bool get isBoardFull => !board.contains('');

  @action
  void updateTicToc(int index) {
    //print("updateTicToc--> ${board[index]}");
    //board[index] = 'kk'; //testing purpose added
    if (board?[index] == '') {
      print("true");
      board?[index] = currentPlayer;
      board = board;
      //print('${board[index]}');
      currentPlayer = currentPlayer == 'X' ? '0' : 'X';
    }
  }

  @action
  void reset() {
    board = ObservableList.of(List.filled(9, ''));
    currentPlayer = 'X';
  }
}
