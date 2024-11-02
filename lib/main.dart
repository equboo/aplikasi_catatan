import 'package:belajar_pemula/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const homePage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xff50c878),
          iconTheme: IconThemeData(
            color: Color(0xffc8e6c9),
          ),
        ),
      ),
    );
  }
}
