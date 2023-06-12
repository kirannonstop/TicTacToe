import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/todo_bloc.dart';
import 'bloc/todo_event.dart';
import 'bloc/todo_model.dart';
import 'bloc/todo_state.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dueDate;
  bool _isCompleted = false;
  final TodoBloc todoBloc = TodoBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBloc.add(LoadTodoEvent());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*todoBloc.add(
      AddTodoEvent(
        todo: Todo(
          title: "Task 1",
          description: "Description 1",
          dueDate: DateTime.now(),
          isCompleted: false,
        ),
      ),
    ); */

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: BlocProvider(
        create: (_) => todoBloc,
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is InitialTodoState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedTodoState) {
              List<Todo> todos = state.todoList;
              print(todos.length);

              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index].title),
                    subtitle: Text(todos[index].description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        todoBloc.add(DeleteTodoEvent(index: index));
                      },
                    ),
                    onTap: () {
                      _showEditDialog(context, todos[index], index);
                    },
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext contextL) {
    showDialog(
      context: contextL,
      builder: (context2) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: IntrinsicWidth(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: "Title"),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: "Description"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      ).then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            _dueDate = pickedDate;
                          });
                        }
                      });
                    },
                    child: Text(
                      _dueDate == null
                          ? "Select Due Date"
                          : "Due Date: ${_dueDate!.toString().split(' ')[0]}",
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Completed"),
                      Checkbox(
                          value: _isCompleted,
                          onChanged: (value) {
                            setState(() {
                              _isCompleted = value!;
                            });
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                _titleController.clear();
                _descriptionController.clear();
                _dueDate = null;
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                String title = _titleController.text;
                String description = _descriptionController.text;
                if (title.isNotEmpty &&
                    description.isNotEmpty &&
                    _dueDate != null) {
                  todoBloc.add(
                    AddTodoEvent(
                      todo: Todo(
                          title: title,
                          description: description,
                          dueDate: _dueDate!,
                          isCompleted: _isCompleted),
                    ),
                  );
                  /*BlocProvider.of<TodoBloc>(contextL).add(
                    AddTodoEvent(
                      todo: Todo(
                          title: title,
                          description: description,
                          dueDate: _dueDate!,
                          isCompleted: _isCompleted),
                    ),
                  );*/
                }
                Navigator.of(context).pop();
                _titleController.clear();
                _descriptionController.clear();
                _dueDate = null;
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext contextL, Todo todo, int index) {
    TextEditingController titleController =
        TextEditingController(text: todo.title);
    TextEditingController descriptionController =
        TextEditingController(text: todo.description);
    DateTime pickedDueDate = todo.dueDate;

    showDialog(
      context: contextL,
      builder: (BuildContext context2) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: "Description"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: contextL,
                    initialDate: pickedDueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  ).then((pickedDate) {
                    if (pickedDate != null) {
                      setState(() {
                        pickedDueDate = pickedDate;
                      });
                    }
                  });
                },
                child:
                    Text("Due Date: ${pickedDueDate.toString().split(' ')[0]}"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                String updatedTitle = titleController.text;
                String updatedDescription = descriptionController.text;
                if (updatedTitle.isNotEmpty &&
                    updatedDescription.isNotEmpty &&
                    pickedDueDate != null) {
                  BlocProvider.of<TodoBloc>(contextL).add(
                    UpdateTodoEvent(
                      index: index,
                      updatedTodo: todo.copyWith(
                        title: updatedTitle,
                        description: updatedDescription,
                        dueDate: pickedDueDate,
                      ),
                    ),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
