import 'dart:async';
import 'package:http/http.dart' show Client;
import 'movie_client.dart';
export 'movie_client.dart';

class OmdbMovieClient implements MovieClient {
  String url = "http://www.omdbapi.com/";
  String apiKey = "[Your API key]";

  Future<String> fetchMovies(String searchWord) {
    Client client = Client();
    return client.get("$url?apikey=$apiKey&s=$searchWord")
                 .then((response) => response.body);
  }

  Future<String> fetchMovie(String imdbID) {
    Client client = Client();
    return client.get("$url?apikey=$apiKey&i=$imdbID")
                 .then((response) => response.body);
  }
}