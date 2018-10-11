import 'dart:async';
import 'package:http/http.dart' show Client;
import 'movie_client.dart';
export 'movie_client.dart';

/// OMDb APIを利用した映画情報取得の具象クラス
class OmdbMovieClient implements MovieClient {
  final String url = "http://www.omdbapi.com/";

  // OMDb API登録時に取得したAPI Keyに差し替えてください。
  final String apiKey = "[Your API Key]";
  
  final Client client = Client();

  /// [searchWord]をもとに映画情報を取得する。
  Future<String> fetchMovies(String searchWord) {
    return client.get("$url?apikey=$apiKey&s=$searchWord")
                 .then((response) => response.body);
  }

  /// 映画を一意に特定する[imdbID]をもとに、映画の詳細情報を取得する。
  Future<String> fetchMovie(String imdbID) {
    return client.get("$url?apikey=$apiKey&i=$imdbID")
                 .then((response) => response.body);
  }
}