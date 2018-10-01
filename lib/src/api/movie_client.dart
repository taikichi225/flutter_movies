import 'dart:async';

abstract class MovieClient {
  Future<String> fetchMovies(String searchWord);
  Future<String> fetchMovie(String id);
}