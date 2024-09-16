import 'package:bloc/bloc.dart';

import '../domain/models/todo.dart';
import '../domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // refrence to todo repo
  final TodoRepo todoRepo;

// LOAD
  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodos();
    emit(todoList);
  }

  Future<void> addTodos(String text) async {
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, text: text);
    await todoRepo.addTodo(newTodo);
    loadTodos();
  }

  Future<void> deleteTodos(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }

  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();
    await todoRepo.updateTodo(updatedTodo);
    loadTodos();
  }
}
