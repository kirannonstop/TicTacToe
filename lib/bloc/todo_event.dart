import 'package:equatable/equatable.dart';
import 'package:todo_flutter_bloc/bloc/todo_model.dart';

abstract class TodoEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadTodoEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;
  AddTodoEvent({required this.todo});
  @override
  // TODO: implement props
  List<Object?> get props => [todo];
}

class UpdateTodoEvent extends TodoEvent {
  final int index;
  final Todo updatedTodo;

  UpdateTodoEvent({required this.index, required this.updatedTodo});
  @override
  // TODO: implement props
  List<Object?> get props => [index, updatedTodo];
}

class DeleteTodoEvent extends TodoEvent {
  final int index;
  DeleteTodoEvent({required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

abstract class TicTacEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateTicTacEvent extends TicTacEvent {
  final int index;
  //final String value;

  UpdateTicTacEvent({required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class ResetTicTacEvent extends TicTacEvent {}
