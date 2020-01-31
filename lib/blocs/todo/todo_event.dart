import 'package:todo_firestore/models/todo_model.dart';

abstract class TodoEvent {}

class FetchAll extends TodoEvent {}

class FetchSingle extends TodoEvent {}

class Add extends TodoEvent {
  Todo todo;

  Add({ this.todo });
}
