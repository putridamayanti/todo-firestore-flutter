import 'todo_api.dart';

class TodoRepository {

  TodoApi todoApi = TodoApi();

  Future fetchAllTodo() async => await todoApi.fetchAllTodo();

  Future addTodo(todo) async => await todoApi.addTodo(todo);
}
