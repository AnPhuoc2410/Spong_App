import 'package:flutter/material.dart';
import 'package:spong_app/ui/home/home.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spong Music',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        fontFamily: 'SF Pro Display',
      ),
      debugShowCheckedModeBanner: false,
      home: const SigninPage(),
    );
  }
}

// OPTIMIZATION: Extracted the reusable text style into a top-level const
// variable. This prevents re-creating the same TextStyle object multiple times
// and allows widgets using it to be declared as const, improving performance.
const TextStyle _underlineTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  decoration: TextDecoration.underline,
);

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    // PERFORMANCE METRIC: To measure how often this widget rebuilds, you can
    // use Flutter DevTools and enable "Highlight Rebuilds". For a static page
    // like this, it should ideally build only once. Adding print statements is
    // another simple way to log build calls.
    // print("SigninPage built at ${DateTime.now()}");

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF3b5998),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),

                  const Icon(Icons.facebook, color: Colors.white, size: 70),

                  const SizedBox(height: 16),

                  // OPTIMIZATION: Added 'const' to the Text and its style.
                  // This widget is now a compile-time constant, so Flutter can
                  // avoid rebuilding it unnecessarily.
                  const Text(
                    "English · Change",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),

                  const SizedBox(height: 50),

                  // NOTE: TextField widgets are stateful internally to handle input.
                  // Their properties, like decoration, can be constant.
                  const TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Email or Phone",
                      hintStyle: TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF334d84),
                        // OPTIMIZATION: Added 'const' to RoundedRectangleBorder.
                        // This ensures the shape object is also a compile-time constant.
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const MusicHomePage()),
                        );
                      },
                      // OPTIMIZATION: Added 'const' to the Text and its style.
                      child: const Text(
                        "LOG IN",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // OPTIMIZATION: Using the pre-defined const TextStyle allows
                  // this Text widget to also be a const.
                  const Text(
                    "Sign Up for Facebook",
                    style: _underlineTextStyle,
                  ),

                  const SizedBox(height: 12),

                  // OPTIMIZATION: The children of this Row are all constant.
                  // By making the list 'const', we ensure all its elements
                  // are also compile-time constants, improving performance.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Forgot Password?",
                        style: _underlineTextStyle,
                      ),
                      SizedBox(width: 15),
                      Icon(Icons.help_outline, color: Colors.white),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}