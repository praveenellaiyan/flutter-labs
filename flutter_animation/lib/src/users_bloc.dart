import 'dart:async';
import 'dart:collection';

import 'package:flutter_animation/src/user.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

enum UserType { NewUser, TopUser }

class UsersBloc {
  /// create user stream through which subscribers receive data
  final _usersSubject = BehaviorSubject<UnmodifiableListView<User>>();

  Stream<List<User>> get users => _usersSubject.stream;

  final _isLoadingSubject = BehaviorSubject<bool>();

  Stream<bool> get isLoading => _isLoadingSubject.stream.startWith(false);

  final userTypeController = StreamController<UserType>();

  Sink<UserType> get userType => userTypeController.sink;

  var cachedUsers = <User>[];

  UsersBloc() {
    getUsersFunc([1, 2, 3, 4, 5]);
    userTypeController.stream.listen((userType) {
      if (userType == UserType.NewUser) {
        getUsersFunc([1, 2, 3, 4, 5]);
      } else if (userType == UserType.TopUser) {
        getUsersFunc([6, 7, 8, 9, 10]);
      }
    });
  }

  void getUsersFunc(List<int> ids) async {
    _isLoadingSubject.add(true);
    await getUsers(ids);
    _usersSubject.add(UnmodifiableListView(cachedUsers));
    _isLoadingSubject.add(false);
  }

  Future<Null> getUsers(List<int> userIds) async {
    final futureUsers = userIds.map((e) => getUserBy(e));
    var users = await Future.wait(futureUsers);
    cachedUsers = users;
  }

  /// Get user details by UserID
  Future<User> getUserBy(int id) async {
    final usersApiUrlBase = 'https://jsonplaceholder.typicode.com/users/$id';
    var usersHttpResponse = await http.get(usersApiUrlBase);
    if (usersHttpResponse.statusCode == 200) {
      return User.fromJson(String.fromCharCodes(usersHttpResponse.bodyBytes));
    }
  }
}
