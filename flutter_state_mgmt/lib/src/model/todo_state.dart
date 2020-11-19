import 'dart:collection';

import 'package:flutter/cupertino.dart';

class Todo extends ChangeNotifier {
  final List<String> _todos = [];

  UnmodifiableListView<String> get todoList => UnmodifiableListView(_todos);

  void addTodo(String todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(String todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  @override
  void dispose() {
    _todos.clear();
  }
}

class Item {
  final String item;
  final bool isCompleted;

  Item(this.item, this.isCompleted);
}
