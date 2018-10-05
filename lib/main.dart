import 'package:flutter/material.dart';
import './src/movie_list.dart';
import './src/api/omdb_movie_client.dart';

// Dartおけるエントリーポイント。
// runAppメソッドに起動したいウィジェットを渡す。
void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    // アプリ全体のルーティングやテーマ等の設定を定義する。
    return MaterialApp(
      // デフォルトで右上にデバッグバナーが出るため、
      // 表示しないように設定する。
      debugShowCheckedModeBanner: false,
      title: "movies",
      // アプリ起動時、最初に描画される画面を設定する。
      home: MovieList(client: OmdbMovieClient(),),
      // アプリ全体のテーマを設定する。
      theme: ThemeData(
        // 以下のテーマをコメントアウトすると、デフォルトテーマに！
        brightness: Brightness.dark
      ),
    );
  }
}

