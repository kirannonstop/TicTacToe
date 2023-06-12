import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_flutter_bloc/store/TicTacToeStore.dart';

class TicTacToeUsingMobX extends StatelessWidget {
  TicTacToeStore ticTacToeStore = TicTacToeStore();
  TicTacToeUsingMobX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("BUILD");
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Observer(builder: (_) {
              return GestureDetector(
                onTap: () {
                  ticTacToeStore.updateTicToc(index);
                  print("Clicked ${ticTacToeStore.board[index]}");
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      ticTacToeStore.board[index],
                      style: TextStyle(fontSize: 40.0, color: Colors.red),
                    ),
                  ),
                ),
              );
            });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          ticTacToeStore.reset();
        },
      ),
    );
  }
}
