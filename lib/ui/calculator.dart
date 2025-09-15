import 'package:flutter/material.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Integer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6600),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFFA500),
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  String _result = "";

  void _calculate(String operator) {
    final num1 = double.tryParse(_num1Controller.text);
    final num2 = double.tryParse(_num2Controller.text);

    if (num1 == null || num2 == null) {
      setState(() {
        _result = "Vui lòng nhập số hợp lệ!";
      });
      return;
    }

    double res;
    switch (operator) {
      case "+":
        res = num1 + num2;
        _result = "Kết quả: $res";
        break;
      case "-":
        res = num1 - num2;
        _result = "Kết quả: $res";
        break;
      case "×":
        res = num1 * num2;
        _result = "Kết quả: $res";
        break;
      case "÷":
        if (num2 == 0) {
          _result = "Không thể chia cho 0";
        } else {
          res = num1 / num2;
          _result = "Kết quả: $res";
        }
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Máy Tính Đơn Giản")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nhập số thứ nhất",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nhập số thứ hai",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Hàng nút phép tính
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _calculate("+"),
                  child: const Text("+"),
                ),
                ElevatedButton(
                  onPressed: () => _calculate("-"),
                  child: const Text("-"),
                ),
                ElevatedButton(
                  onPressed: () => _calculate("×"),
                  child: const Text("×"),
                ),
                ElevatedButton(
                  onPressed: () => _calculate("÷"),
                  child: const Text("÷"),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}