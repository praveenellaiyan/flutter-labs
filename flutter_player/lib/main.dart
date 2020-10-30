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
      body: SafeArea(
        child: PlayerDashboard(),
      ),
    );
  }
}

class PlayerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: AlbumArt(),
          flex: 8,
        ),
        Flexible(
          child: Track(),
          flex: 2,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class Track extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyPlayer();
  }
}

class AlbumArt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
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

  double _playerPosition = 0.0;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
  }

  void _play(bool isLocal) async {
    if (isLocal) {
      await _audioCache.play('moonlight.mp3');
      int duration = await _audioPlayer.getDuration();
      _audioPlayer.onAudioPositionChanged.listen((Duration d) {
        double position = d.inMilliseconds / duration;
        setState(() => _playerPosition = position);
      });
      setState(() => _isPlaying = true);
    } else {
      await _audioPlayer.play(
          'https://incompetech.filmmusic.io/song/6671-moonlight-beach.mp3');
    }
  }

  void _stop() async {
    await _audioPlayer.stop();
    setState(() => _isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Slider(
          value: _playerPosition,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.fast_rewind), onPressed: () {}),
            IconButton(
                icon: _isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
                onPressed: () {
                  if (_isPlaying) {
                    _stop();
                  } else {
                    _play(true);
                  }
                }),
            IconButton(icon: Icon(Icons.fast_forward), onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
