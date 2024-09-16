import 'package:isar/isar.dart';
import '../../domain/models/todo.dart';
part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool is_Completed;

  // Convert Isar object to pure object to use in the app
  Todo toDomain() {
    return Todo(id: id, text: text, is_Completed: is_Completed);
  }

  // Convert Todo object to Isar object to store in the DB
      static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..is_Completed = todo.is_Completed;
  }
}
