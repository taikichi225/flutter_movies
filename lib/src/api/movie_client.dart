import 'dart:async';

/// 映画情報取得インターフェース
abstract class MovieClient {
  Future<String> fetchMovies(String searchWord);
  Future<String> fetchMovie(String id);
}