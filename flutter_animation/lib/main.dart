import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_animation/src/user.dart';
import 'package:flutter_animation/src/users_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: LoadingContent(widget.usersBloc.isLoading),
      ),
      body: StreamBuilder<UnmodifiableListView<User>>(
        stream: widget.usersBloc.users,
        initialData: UnmodifiableListView<User>([]),
        builder: (context, snapshot) => ListView(
          children: snapshot.data.map((user) => buildUser(user)).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("1-5 Users")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("6-10 Users"))
        ],
        onTap: (index) {
          if (index == 0) {
            widget.usersBloc.userType.add(UserType.NewUser);
          } else if (index == 1) {
            widget.usersBloc.userType.add(UserType.TopUser);
          }
          setState(() {
            _currentIndex = index;
          });
        },
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

class LoadingContent extends StatefulWidget {
  final Stream<bool> isLoading;

  LoadingContent(this.isLoading);

  @override
  _LoadingContentState createState() => _LoadingContentState(isLoading);
}

class _LoadingContentState extends State<LoadingContent>
    with SingleTickerProviderStateMixin {
  final Stream<bool> isLoading;
  AnimationController _controller;

  _LoadingContentState(this.isLoading);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isLoading,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          /*return CircularProgressIndicator(
            backgroundColor: Colors.white,
          );*/
          _controller.forward().then((value) => _controller.reverse());
          return FadeTransition(
              child: Icon(FontAwesomeIcons.truckLoading),
              opacity: Tween(begin: 0.5, end: 1.0).animate(
                  CurvedAnimation(curve: Curves.easeIn, parent: _controller)));
        } else {
          return Container();
        }
      },
    );
  }
}
