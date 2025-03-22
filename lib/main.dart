import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Todo List', home: TodoListPage());
  }
}

// Model for a todo item.
class Todo {
  final String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [
    Todo(title: 'Buy groceries'),
    Todo(title: 'Clean the house'),
    Todo(title: 'Finish homework'),
    Todo(title: 'Call mom'),
  ];

  void _toggleTodo(int index) {
    setState(() {
      if (!todos[index].isDone) {
        // Mark as done, add strike-through, and move to bottom.
        todos[index].isDone = true;
        final todo = todos.removeAt(index);
        todos.add(todo);
      } else {
        // Remove strike-through and move back to the top.
        todos[index].isDone = false;
        final todo = todos.removeAt(index);
        todos.insert(0, todo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                decoration:
                    todo.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
              ),
            ),
            onTap: () => _toggleTodo(index),
          );
        },
      ),
    );
  }
}
