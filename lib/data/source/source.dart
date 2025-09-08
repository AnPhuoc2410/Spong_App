import 'dart:convert';

import '../model/song.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final url = dotenv.env['API_URL'];
    final response = await http.get(Uri.parse(url!));
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);//Dùng utf8.decode để chuyển bytes thành chuỗi (tránh lỗi tiếng Việt/Kanji bị sai encoding
      var songWrapper = jsonDecode(bodyContent) as Map;
      var songList = songWrapper['songs'];
      return songList.map((song) => Song.fromJson(song)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }
}
