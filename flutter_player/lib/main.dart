import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Player'),
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
      body: MyPlayer(),
    );
  }
}

class MyPlayer extends StatefulWidget {
  @override
  _MyPlayerState createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  bool _isPlaying = false;
  AudioPlayer _audioPlayer;
  AudioCache _audioCache;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
  }

  void _play(bool isLocal) async {
    if (isLocal) {
      await _audioCache.play('moonlight.mp3');
    } else {}
  }

  void _stop(bool isLocal) async {
    if (isLocal) {
      await _audioPlayer.stop();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: _isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
        onPressed: () {
          if (_isPlaying) {
            _stop(true);
          } else {
            _play(true);
          }
          setState(() {
            _isPlaying = !_isPlaying;
          });
        });
  }
}
