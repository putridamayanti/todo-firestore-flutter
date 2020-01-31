import 'package:intl/intl.dart';

class Todo {
  String key;
  DateTime date;
  String time;
  String color;
  String todo;

  Todo({
    this.key,
    this.date,
    this.time,
    this.color,
    this.todo
  });

  factory Todo.fromMap(Map json) {
    final date = DateFormat('yyyy-MM-DD').format(json['date'].toDate());
    final time = DateFormat('kk:mm a').format(json['time'].toDate());
    return new Todo(
      key: json['key'],
      date: DateTime.parse(date),
      time: time,
      color: json['color'],
      todo: json['todo']
    );
  }

  Map toJson() {
    return {
      'date' : date,
      'time' : date,
      'color' : color,
      'todo' : todo
    };
  }
}
