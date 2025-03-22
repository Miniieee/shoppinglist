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

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // List of todo items as strings
  List<String> todos = [
    'Buy groceries',
    'Clean the house',
    'Finish homework',
    'Call mom',
  ];

  void _moveToBottom(int index) {
    setState(() {
      // Remove the item from its current position and add it to the end of the list
      final String item = todos.removeAt(index);
      todos.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index]),
            onTap: () => _moveToBottom(index),
          );
        },
      ),
    );
  }
}
