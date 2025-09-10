import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/song.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final url = dotenv.env['URL'] ?? '';
    final response = await http.get(Uri.tryParse(url)!);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);//Dùng utf8.decode để chuyển bytes thành chuỗi (tránh lỗi tiếng Việt/Kanji bị sai encoding
      var songWrapper = jsonDecode(bodyContent) as Map;
      var songList = songWrapper['songs'] as List;
      List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
      return songs;
    } else {
      return null;
    }
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async{
    final String response = await rootBundle.loadString('assets/songs.json');
    final jsonData = jsonDecode(response) as Map;
    var songList = jsonData['songs'] as List;
    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    return songs;
  }
}
