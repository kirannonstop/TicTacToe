import 'package:equatable/equatable.dart';
import 'package:todo_flutter_bloc/bloc/todo_model.dart';

abstract class TodoState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialTodoState extends TodoState {}

class LoadedTodoState extends TodoState {
  final List<Todo> todoList;
  LoadedTodoState({required this.todoList});
  @override
  // TODO: implement props
  List<Object?> get props => [todoList];
}

class TicTacState extends Equatable {
  final List<String> board;
  final String currentPlayer;

  TicTacState({required this.board, required this.currentPlayer});
  @override
  // TODO: implement props
  List<Object?> get props => [board, currentPlayer];
}
