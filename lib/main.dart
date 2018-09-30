import 'package:flutter/material.dart';
import './movie_list.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "movies",
      home: MovieList(),
      theme: ThemeData(
        brightness: Brightness.dark
      ),
    );
  }
}

