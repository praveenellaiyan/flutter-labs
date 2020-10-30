import 'dart:async';
import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:http_caching/src/user.dart';
import 'package:rxdart/rxdart.dart';

enum UserType { NewUser, TopUser }

class UsersBloc {
  /// create user stream through which subscribers receive data
  final _usersSubject = BehaviorSubject<UnmodifiableListView<User>>();

  Stream<List<User>> get users => _usersSubject.stream;

  final userTypeController = StreamController<UserType>();

  Sink<UserType> get userType => userTypeController.sink;

  var fetchedUsers = <User>[];

  HashMap<int, User> _cacheUsers;

  UsersBloc() {
    _cacheUsers = HashMap();
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
    await getUsers(ids).then((_) {
      _usersSubject.add(UnmodifiableListView(fetchedUsers));
    });
  }

  Future<Null> getUsers(List<int> userIds) async {
    final futureUsers = userIds.map((e) => getUserBy(e));
    var users = await Future.wait(futureUsers);
    fetchedUsers = users;
  }

  /// Get user details by UserID
  Future<User> getUserBy(int id) async {
    if (!_cacheUsers.containsKey(id)) {
      final usersApiUrlBase = 'https://jsonplaceholder.typicode.com/users/$id';
      var usersHttpResponse = await http.get(usersApiUrlBase);
      if (usersHttpResponse.statusCode == 200) {
        _cacheUsers[id] =
            User.fromJson(String.fromCharCodes(usersHttpResponse.bodyBytes));
      } else {
        throw UserAPIError('User for $id not found');
      }
    }
    return _cacheUsers[id];
  }
}

class UserAPIError extends Error {
  String message;

  UserAPIError(this.message);
}
