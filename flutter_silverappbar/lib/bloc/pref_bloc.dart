import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  final bool showWebView;

  const Preference(this.showWebView);
}

class PrefBloc {
  /// create user stream through which subscribers receive data
  final _prefSubject = BehaviorSubject<Preference>();

  Stream<Preference> get prefs => _prefSubject.stream;

  final webViewCtrl = StreamController<bool>();

  Sink<bool> get showWebViewSink => webViewCtrl.sink;

  PrefBloc() {
    loadPreferences();
    webViewCtrl.stream.listen((pref) {
      savePreferences(Preference(pref));
    });
  }

  Future<void> loadPreferences() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var showWebViewPref = sharedPrefs.getBool('showWebView') ?? false;
    _prefSubject.add(Preference(showWebViewPref));
  }

  Future<void> savePreferences(Preference preference) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool('showWebView', preference.showWebView);
    _prefSubject.add(preference);
  }

  void close() {
    webViewCtrl.close();
    _prefSubject.close();
  }
}
