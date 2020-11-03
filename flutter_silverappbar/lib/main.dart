import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                childCount: players.length,
              ),
            )
          ],
        ));
  }

  Widget buildRow(Player player) {
    return ExpansionTile(
      key: Key(player.playerName),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Text(player.playerName)),
          Expanded(child: Text(player.skill)),
        ],
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(child: Text("More Info")),
            IconButton(
              icon: Icon(Icons.launch_outlined),
              onPressed: () async {
                if (await canLaunch(player.url)) {
                  await launch(player.url);
                }
              },
            ),
            IconButton(
                icon: Icon(Icons.web_asset_rounded),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerDetailsWeb(player.url)),
                  );
                }),
          ],
        )
      ],
    );
  }
}

class PlayerDetailsWeb extends StatelessWidget {
  final String playerUrl;

  PlayerDetailsWeb(this.playerUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player Web Details"),
      ),
      body: WebView(
        initialUrl: playerUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
