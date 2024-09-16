import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/models/todo.dart';

class CheckedPage extends StatelessWidget {
  CheckedPage({
    super.key,
    required this.todos,
  });

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text("Done Page"),
      ),
      body: SafeArea(
        child: todos.isEmpty
            ? const Center(child: Text('No completed tasks'))
            : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.yellow,
                      child: ListTile(
                          title: Text(todo.text),
                          leading: const Icon(Icons.check_circle,
                              color: Colors.green)),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
