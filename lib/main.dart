import 'package:flutter/material.dart';
import './src/movie_list.dart';
import './src/api/omdb_movie_client.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "movies",
      home: MovieList(client: OmdbMovieClient(),),
      theme: ThemeData(
        brightness: Brightness.dark
      ),
    );
  }
}

