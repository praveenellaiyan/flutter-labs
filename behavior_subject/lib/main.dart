import 'dart:collection';

import 'package:behavior_subject/src/user.dart';
import 'package:behavior_subject/src/users_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  final usersBloc = UsersBloc();
  runApp(MyApp(usersBloc: usersBloc));
}

class MyApp extends StatelessWidget {
  final UsersBloc usersBloc;

  MyApp({
    Key key,
    this.usersBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Users', usersBloc: usersBloc),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.usersBloc}) : super(key: key);

  final String title;
  final UsersBloc usersBloc;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<User>>(
        stream: widget.usersBloc.users,
        initialData: UnmodifiableListView<User>([]),
        builder: (context, snapshot) => ListView(
          children: snapshot.data.map((user) => buildUser(user)).toList(),
        ),
      ),
    );
  }

  Widget buildUser(User user) {
    return ExpansionTile(
      title: Text(user.name),
      subtitle: Text(user.company.name),
    );
  }
}
