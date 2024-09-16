import 'package:isar/isar.dart';
import 'package:todo/data/models/isar_todo.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;

  IsarTodoRepo(this.db);

  @override
  Future<void> addTodo(Todo todo)async {
    final todoIsar = TodoIsar.fromDomain(todo);
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> deleteTodo(Todo todo) async{
    return db.writeTxn(()=>db.todoIsars.delete(todo.id));
  }

  @override
  Future<List<Todo>> getTodos() async {
    final todos = await db.todoIsars.where().findAll();
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) async{  final todoIsar = TodoIsar.fromDomain(todo);
  return db.writeTxn(() => db.todoIsars.put(todoIsar));}
}
