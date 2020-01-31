import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:todo_firestore/models/todo_model.dart';

class TodoApi {
  Firestore firestore = Firestore.instance;

  Future<List<Todo>> fetchAllTodo() async {
    try {
      final response = await firestore.collection('todo').getDocuments();
      final documents = response.documents;
      final todos = documents.map((item) => Todo.fromMap(item.data)).toList();
      return todos;
    } catch(e) {
      print(e);
    }
  }

  Future fetchByDate() async {
    try {
      final response = await firestore.collection('todo').getDocuments();
      final documents = response.documents;
      final todos = documents.map((item) => Todo.fromMap(item.data)).toList();
      return todos;
    } catch(e) {
      print(e);
    }
  }

  Future addTodo(Todo todo) async {
    print(todo.toJson());
    try {
      final response = await firestore.collection('todo').add({
        'color': todo.color,
        'todo' : todo.todo,
        'date' : todo.date,
        'time' : todo.date
      });
      print(response);
      return response;
    } catch(e) {
      print(e);
    }
  }
}
