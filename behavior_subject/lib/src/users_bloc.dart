import 'dart:collection';

import 'package:behavior_subject/src/user.dart';
import 'package:http/http.dart' as http;
import 'package:quiver/iterables.dart';
import 'package:rxdart/rxdart.dart';

class UsersBloc {
  Stream<List<User>> get users => _usersSubject.stream;

  final _usersSubject = BehaviorSubject<UnmodifiableListView<User>>();

  var cachedUsers = <User>[];

  UsersBloc() {
    getUsers().then((_) {
      _usersSubject.add(UnmodifiableListView(cachedUsers));
    });
  }

  Future<Null> getUsers() async {
    final futureUsers = range(1, 10).map((e) => getUserBy(e));
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
