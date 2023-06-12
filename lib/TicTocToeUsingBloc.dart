import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_bloc/bloc/todo_bloc.dart';
import 'package:todo_flutter_bloc/bloc/todo_event.dart';
import 'package:todo_flutter_bloc/bloc/todo_state.dart';

class TicTocToeUsingBloc extends StatelessWidget {
  const TicTocToeUsingBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TicTacBloc ticTacBloc = BlocProvider.of<TicTacBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: BlocBuilder<TicTacBloc, TicTacState>(builder: (context, state) {
        return GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ticTacBloc.add(UpdateTicTacEvent(index: index));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      state.board[index],
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          ticTacBloc.add(ResetTicTacEvent());
        },
      ),
    );
  }
}
