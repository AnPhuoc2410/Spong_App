import 'dart:async';

import '../../data/model/song.dart';
import '../../data/repository/repository.dart';

class MusicAppViewModel {
  StreamController<List<Song>> songStream = StreamController();

  void loadSongs() {
    final repository = MusicRepository();
    repository.loadData().then((value) => songStream.add(value!));
  }
}
