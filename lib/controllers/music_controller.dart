import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/mock/mock_data.dart';
import '../data/models/playlist_track.dart';

class MusicController extends ChangeNotifier {
  PlaylistTrack _current = playlist.first;
  PlaylistTrack get current => _current;
  double progress = 0;
  Timer? _timer;

  void select(PlaylistTrack track) {
    _current = track.copyWith(isPlaying: true);
    progress = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      progress += 1 / track.durationSec;
      if (progress >= 1) {
        timer.cancel();
        progress = 0;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void toggle() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    } else {
      select(_current);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
