import 'package:todo/domain/models/todo.dart';

abstract class TodoRepo{

  // get list of todo
  Future<List<Todo>> getTodos();
// add todo
Future<void> addTodo(Todo todo);
// uodate todo
Future <void> updateTodo(Todo todo);
// delete
  Future <void> deleteTodo(Todo todo);








}