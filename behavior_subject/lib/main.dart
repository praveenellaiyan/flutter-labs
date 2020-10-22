import 'package:behavior_subject/src/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> userIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  Future<User> getUserBy(int id) async {
    final usersApiUrlBase = 'https://jsonplaceholder.typicode.com/users/$id';
    var usersHttpResponse = await http.get(usersApiUrlBase);
    if (usersHttpResponse.statusCode == 200) {
      return User.fromJson(String.fromCharCodes(usersHttpResponse.bodyBytes));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
          children: userIds
              .map((e) => (FutureBuilder<User>(
                    future: getUserBy(e),
                    builder:
                        (BuildContext context, AsyncSnapshot<User> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return buildUser(snapshot.data);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )))
              .toList()),
    );
  }

  Widget buildUser(User user) {
    return ExpansionTile(
      title: Text(user.name),
      subtitle: Text(user.company.name),
    );
  }
}
