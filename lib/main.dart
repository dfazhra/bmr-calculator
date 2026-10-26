
import 'package:flutter/material.dart';
import 'pages/input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0B0D23),
        scaffoldBackgroundColor: const Color(0xFF0B0D23),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF151D31),
          centerTitle: true,
          elevation: 0.0,
          foregroundColor: Color(0xFFF1EFF8),
        ),
      ),
      home: const InputPage(),
    );
  }
}
