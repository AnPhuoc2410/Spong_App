import 'dart:math';

import 'package:flutter/material.dart';

class RandomNumberApp extends StatelessWidget {
  const RandomNumberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Integer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6600),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFFA500)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const RandomNumberScreen(),
    );
  }
}

class RandomNumberScreen extends StatefulWidget {
  const RandomNumberScreen({super.key});

  @override
  State<RandomNumberScreen> createState() => _RandomNumberScreenState();
}

class _RandomNumberScreenState extends State<RandomNumberScreen> {
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  int? _randomNumber;

  void _generateRandom() {
    if (_minController.text.isEmpty || _maxController.text.isEmpty) return;

    final min = int.tryParse(_minController.text);
    final max = int.tryParse(_maxController.text);

    if (min == null || max == null || min > max) return;

    final random = Random();
    setState(() {
      _randomNumber = min + random.nextInt(max - min + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Random Number")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _minController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nhập Min",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _maxController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nhập Max",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateRandom,
              child: const Text("Generate"),
            ),
            const SizedBox(height: 20),
            if (_randomNumber != null)
              Text(
                "Kết quả: $_randomNumber",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
