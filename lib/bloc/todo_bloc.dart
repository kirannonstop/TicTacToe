import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter_bloc/bloc/todo_event.dart';
import 'package:todo_flutter_bloc/bloc/todo_model.dart';
import 'package:todo_flutter_bloc/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(InitialTodoState()) {
    on<TodoEvent>((event, emit) async {
      print("START");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Todo> todos = (prefs.getStringList('todos') ?? []).map((json) {
        return Todo.fromJson(jsonDecode(json));
      }).toList();
      if (event is LoadTodoEvent) {
        print("LoadTodoEvent");
        emit(LoadedTodoState(todoList: todos));
      }
      if (event is AddTodoEvent) {
        print("AddTodoEvent");
        todos.add(event.todo);
        await prefs.setStringList(
            'todos',
            todos.map((todo) {
              return jsonEncode(todo.toJson());
            }).toList());
        emit(LoadedTodoState(todoList: todos));
      } else if (event is UpdateTodoEvent) {
        print("UpdateTodoEvent");
        // List<Todo> todos = (prefs.getStringList('todos') ?? []).map((json) {
        //   return Todo.fromJson(jsonDecode(json));
        // }).toList();
        if (event.index >= 0 && event.index < todos.length) {
          todos[event.index] = event.updatedTodo;
          await prefs.setStringList(
              'todos',
              todos.map((todo) {
                return jsonEncode(todo.toJson());
              }).toList());
        }
        emit(LoadedTodoState(todoList: todos));
      } else if (event is DeleteTodoEvent) {
        print("DeleteTodoEvent");
        // List<Todo> todos = (prefs.getStringList('todos') ?? []).map((json) {
        //   return Todo.fromJson(jsonDecode(json));
        // }).toList();
        if (event.index >= 0 && event.index < todos.length) {
          todos.removeAt(event.index);
          await prefs.setStringList(
              'todos',
              todos.map((todo) {
                return jsonEncode(todo.toJson());
              }).toList());
        }
        emit(LoadedTodoState(todoList: todos));
      }
    });
  }
}

class TicTacBloc extends Bloc<TicTacEvent, TicTacState> {
  TicTacBloc()
      : super(TicTacState(board: List.filled(9, ''), currentPlayer: 'X')) {
    on<TicTacEvent>((event, emit) async {
      print("START TIC TAC");
      if (event is UpdateTicTacEvent) {
        if (state.board[event.index] == '') {
          final List<String> updatedList = List.from(state.board);
          updatedList[event.index] = state.currentPlayer;
          final String nextPlayer = state.currentPlayer == 'X' ? '0' : 'X';
          emit(TicTacState(board: updatedList, currentPlayer: nextPlayer));
        }
      } else if (event is ResetTicTacEvent) {
        emit(TicTacState(board: List.filled(9, ''), currentPlayer: 'X'));
      }
    });
  }
}
