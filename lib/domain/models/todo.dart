class Todo {
  final int id;
  final String text;
  bool is_Completed;

  Todo({required this.id, required this.text, this.is_Completed = false});

  Todo toggleCompletion() {
    return Todo(id: id, text: text, is_Completed: !is_Completed);
  }
}
