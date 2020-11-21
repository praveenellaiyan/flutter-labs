import 'package:flutter/material.dart';
import 'package:flutter_state_mgmt/src/model/item.dart';
import 'package:flutter_state_mgmt/src/model/todo_state.dart';
import 'package:provider/provider.dart';

void main() {
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
  String _inputTodo = '';
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    var todo = context.watch<Todo>();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: todo.todoList.length,
              itemBuilder: (context, index) {
                final item = todo.todoList.elementAt(index);
                return Row(
                  children: [
                    Text(item.item),
                    Checkbox(
                      value: item.isCompleted,
                      onChanged: (value) {
                        todo.updateTodo(
                            index, Item.fromOld(item, isCompleted: value));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        todo.removeTodo(index);
                      },
                    )
                  ],
                );
              },
            ),
          ),
          TextField(
            showCursor: true,
            onChanged: (value) {
              setState(() {
                _inputTodo = value;
              });
            },
          ),
          Checkbox(
            value: _isCompleted,
            onChanged: (value) {
              setState(() {
                _isCompleted = value;
              });
            },
          ),
          RaisedButton(
            onPressed: () {
              todo.addTodo(Item(_inputTodo, _isCompleted));
            },
            child: FlatButton.icon(
              label: Text("Add"),
              icon: Icon(Icons.add),
            ),
          ),
        ]));
  }
}
