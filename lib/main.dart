import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// Ctrl Alt L to format
// Ctrl Alt O to optimize imports
// Ctrl Alt M to extract method
// Ctrl Alt V to extract variable
// Ctrl Alt F to extract field
// Ctrl Alt C to extract class