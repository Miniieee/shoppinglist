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

class TodoListPage extends StatelessWidget {
  // List of todo items as strings
  final List<String> todos = [
    'Buy groceries',
    'Clean the house',
    'Finish homework',
    'Call mom',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(todos[index]));
        },
      ),
    );
  }
}
