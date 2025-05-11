import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/presentation/checked_page.dart';
import 'package:todo/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    TextEditingController textEditingController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Form(
            key: formKey,
            child: TextFormField(
              validator: (String? str) {
                if (str!.isEmpty) {
                  return "Enter Text";
                }
                return null;
              },
              cursorColor: Colors.yellow,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.yellow),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: " Enter a Task"),
              controller: textEditingController,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    todoCubit.addTodos(textEditingController.text);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "TO DO",
          ),
          backgroundColor: Colors.yellow,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: () => _showAddTodoBox(context),
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
      return Column(
          children: [
          Expanded(
          child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
        final todo = todos[index];
        return Padding(
            padding: const EdgeInsets.all(8.0),
    child: Card(
    color: Colors.yellow,
    child: ListTile(
    title: Text(todo.text),
    leading: Checkbox(
    value: todo.is_Completed,
    onChanged: (value) =>
    todoCubit.toggleCompletion(todo),
    ),
    trailing: IconButton(
    icon: const Icon(Icons.cancel),
    onPressed: () => todoCubit.deleteTodos(todo),
    ),
    ),),
        );
          }),
          ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, fixedSize: Size(160, 50)),
                onPressed: () {
                  final completedTodos =
                  todos.where((todo) => todo.is_Completed).toList();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CheckedPage(todos: completedTodos),
                    ),
                  );
                },
                child: Text(
                  "Completed Tasks ",
                  style: TextStyle(color: Colors.yellow, fontSize: 10),
                )),
            SizedBox(
              height: 20,
            )
          ],
      );
        },
        ),
    );
  }
}