import 'package:flutter/material.dart';
import 'package:flutter_state_mgmt/src/model/todo_state.dart';
import 'package:provider/provider.dart';

void main() {
  /*runApp(ChangeNotifierProvider(
    create: (context) => Todo(),
    child: MyApp(),
  ));*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Todo(),
      child: MaterialApp(
        title: 'Flutter State Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoPage(title: 'Flutter State Management'),
      ),
    );
  }
}

class TodoPage extends StatefulWidget {
  TodoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  String inputTodo;

  @override
  Widget build(BuildContext context) {
    var todo = context.watch<Todo>();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: [
          Expanded(
            child: ListView(
              children: todo.todoList.map((e) {
                return Row(
                  children: [
                    Text(e),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        todo.removeTodo(e);
                      },
                    )
                  ],
                );
              }).toList(),
            ),
          ),
          TextField(
            showCursor: true,
            onChanged: (value) {
              setState(() {
                inputTodo = value;
              });
            },
          ),
          RaisedButton(
            onPressed: () {
              todo.addTodo(inputTodo);
            },
            child: FlatButton.icon(
              label: Text("Add"),
              icon: Icon(Icons.add),
            ),
          ),
        ]));
  }
}
