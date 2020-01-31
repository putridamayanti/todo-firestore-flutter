import 'package:bloc/bloc.dart';

import 'todo_event.dart';
import 'todo_state.dart';
import 'package:todo_firestore/repositories/todo/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  TodoRepository todoRepository = TodoRepository();

  @override
  get initialState => TodoUnloaded();

  @override
  Stream<TodoState> mapEventToState(event) async* {
    if (event is FetchAll) {
      yield TodoLoading();
      final todos = await todoRepository.fetchAllTodo();
      yield TodosLoaded(todos: todos);
    }

    if (event is Add) {
      final todo = await todoRepository.addTodo(event.todo);
      print(todo);
      yield TodoSuccess();
    }
  }
}
