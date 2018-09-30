import 'dart:async';
import 'package:http/http.dart' show Client;

class MovieClient {
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