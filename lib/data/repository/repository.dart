import 'package:spong_app/data/source/source.dart';

import '../model/song.dart';

abstract interface class Repository {
  Future<List<Song>?> loadData();
}

class MusicRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    await _remoteDataSource.loadData().then((remoteSongs){

  })
    return songs;
  }
}