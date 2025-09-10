import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../data/repository/repository.dart';
import '../ui/home/home.dart';

Future<void> main() async {
  await dotenv.load();

  var repository = MusicRepository();
  var songs = await repository.loadData();
  if (songs != null){
    for (var song in songs) {
      debugPrint(song.toString());
    }
  }
  runApp(const MusicApp());
}

// Ctrl Alt L to format
// Ctrl Alt O to optimize imports
// Ctrl Alt M to extract method
// Ctrl Alt V to extract variable
// Ctrl Alt F to extract field
// Ctrl Alt C to extract class