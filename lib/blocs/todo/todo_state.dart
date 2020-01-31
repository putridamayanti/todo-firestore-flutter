abstract class TodoState {}

class TodoUnloaded extends TodoState {}

class TodoLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List todos;

  TodosLoaded({ this.todos });
}

class TodoLoaded extends TodoState {
  final todo;

  TodoLoaded({ this.todo });
}

class TodoSuccess extends TodoState {}

class TodoError extends TodoState {}
