import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_state_mgmt/src/model/item.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// replace item at specified index on index
/// if element doesn't exit at index, does nothing
extension ListExtension on List<Item> {
  void replaceAt(int index, Item item) {
    if (this.contains(elementAt(index))) {
      this.replaceRange(index, index + 1, [item]);
    }
  }
}

class Todo extends ChangeNotifier {
  final List<Item> _cachedTodo = [];
  Box _todoBox;

  UnmodifiableListView<Item> get todoList => UnmodifiableListView(_cachedTodo);

  Todo() {
    _initializeAppData();
  }

  Future<void> _initializeAppData() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
    Hive.registerAdapter(ItemAdapter());
    await Hive.openBox('items');
    _todoBox = Hive.box('items');
    _cachedTodo.addAll(
        _todoBox.values.whereType<Item>().where((item) => _isValidItem(item)));
    notifyListeners();
  }

  void addTodo(Item todo) {
    _cachedTodo.add(todo);
    _todoBox.add(todo);
    notifyListeners();
  }

  void removeTodo(int index) {
    _cachedTodo.removeAt(index);
    _todoBox.deleteAt(index);
    notifyListeners();
  }

  void updateTodo(int index, Item item) {
    _cachedTodo.replaceAt(index, item);
    _todoBox.putAt(index, item);
    notifyListeners();
  }

  bool _isValidItem(Item item) {
    return item.item != null && item.isCompleted != null;
  }

  @override
  void dispose() async {
    _cachedTodo.clear();
    super.dispose();
    await _todoBox.compact();
    await _todoBox.close();
  }
}
