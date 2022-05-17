import 'package:flutter/material.dart';
import 'package:tictactoe/home.dart';
import 'dart:convert';
void main() => runApp(const MaterialApp(
    home: Main()
));

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}