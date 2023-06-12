import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  Todo(
      {required this.title,
      required this.description,
      required this.dueDate,
      required this.isCompleted});

  @override
  // TODO: implement props
  List<Object?> get props => [title, description, dueDate, isCompleted];
  Todo copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Todo(
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        isCompleted: isCompleted ?? this.isCompleted);
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      isCompleted: json['isCompleted'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}
