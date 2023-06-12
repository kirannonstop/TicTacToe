// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TicTacToeStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TicTacToeStore on _TicTacToeStore, Store {
  late final _$boardAtom =
      Atom(name: '_TicTacToeStore.board', context: context);

  @override
  ObservableList<String> get board {
    _$boardAtom.reportRead();
    return super.board;
  }

  @override
  set board(ObservableList<String> value) {
    _$boardAtom.reportWrite(value, super.board, () {
      super.board = value;
    });
  }

  late final _$currentPlayerAtom =
      Atom(name: '_TicTacToeStore.currentPlayer', context: context);

  @override
  String get currentPlayer {
    _$currentPlayerAtom.reportRead();
    return super.currentPlayer;
  }

  @override
  set currentPlayer(String value) {
    _$currentPlayerAtom.reportWrite(value, super.currentPlayer, () {
      super.currentPlayer = value;
    });
  }

  late final _$_TicTacToeStoreActionController =
      ActionController(name: '_TicTacToeStore', context: context);

  @override
  void updateTicToc(int index) {
    final _$actionInfo = _$_TicTacToeStoreActionController.startAction(
        name: '_TicTacToeStore.updateTicToc');
    try {
      return super.updateTicToc(index);
    } finally {
      _$_TicTacToeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_TicTacToeStoreActionController.startAction(
        name: '_TicTacToeStore.reset');
    try {
      return super.reset();
    } finally {
      _$_TicTacToeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
board: ${board},
currentPlayer: ${currentPlayer}
    ''';
  }
}
