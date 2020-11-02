import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'src/player.dart';

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
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Players of the Year"),
              // pinned: true,
              floating: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => buildRow(players[index]),
                  childCount: players.length),
            )
          ],
          // children: players.map((e) => buildRow(e)).toList(),
        ));
  }

  Widget buildRow(Player player) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(child: Text(player.playerName)),
          Expanded(child: Text(player.skill)),
        ],
      ),
    );
  }
}
