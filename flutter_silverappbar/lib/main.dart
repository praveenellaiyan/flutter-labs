import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_silverappbar/bloc/pref_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'src/player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefBloc = PrefBloc();
  runApp(MyApp(prefBloc: prefBloc));
}

class MyApp extends StatelessWidget {
  final PrefBloc prefBloc;

  MyApp({
    Key key,
    this.prefBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        prefBloc: prefBloc,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.prefBloc}) : super(key: key);

  final String title;
  final PrefBloc prefBloc;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                _showPreferenceModal(context, widget.prefBloc);
              },
            )
          ],
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

  void _showPreferenceModal(BuildContext buildContext,
      PrefBloc prefBloc) async {
    showModalBottomSheet(
      context: buildContext,
      builder: (buildContext) {
        return StreamBuilder<Preference>(
            stream: prefBloc.prefs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                  body: Center(
                    child: Switch(
                      value: snapshot.data.showWebView,
                      onChanged: (showWebView) {
                        prefBloc.showWebViewSink.add(showWebView);
                      },
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }
        );
      },
    );
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
            StreamBuilder<Preference>(
                stream: widget.prefBloc.prefs,
                initialData: Preference(false),
                builder: (BuildContext context,
                    AsyncSnapshot<Preference> snapshot) {
                  if (snapshot.hasData && snapshot.data.showWebView) {
                    return IconButton(
                        icon: Icon(Icons.web_asset_rounded),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlayerDetailsWeb(player.url)),
                          );
                        });
                  }
                  return Container();
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
