import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import './api/omdb_movie_client.dart';
import './api/movie_client.dart';
import './models/movie_detail_model.dart';

/// 映画詳細画面
class MovieDetail extends StatelessWidget {
  final String imdbID;
  final MovieClient client;

  MovieDetail({
    Key key,
    // OMDb APIにおける映画を一意に特定するID。
    @required this.imdbID,
    // テストしやすくするため、MovieClientを外部から注入する。
    @required this.client,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      // Futureをもとにウィジェットを構築する。
      body: FutureBuilder(
        // futureプロパティにFutureを設定する。
        future: fetchMovie(),
        // Futureのスナップショットに応じて、ウィジェットを構築する。
        builder: (BuildContext context, AsyncSnapshot<MovieDetailModel> snapshot) {
          // スナップショットに非同期処理の結果が返っているか確認する。
          // もし返っていなければ、ローディング画面を表示する。
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }

          // 非同期処理の結果の値を取り出す。
          MovieDetailModel movie = snapshot.data;
          // ウィジェットを構築する。
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: buildListItem(movie),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 映画詳細画面の表示項目リストを返す。
  List<Widget> buildListItem(MovieDetailModel movie) {
    return [
      Hero(tag:movie.imdbID, child: Image.network(movie.poster, fit: BoxFit.contain,),),
      ListTile(title: Text("Title"), subtitle: Text(movie.title),),
      ListTile(title: Text("Year"), subtitle: Text(movie.year),),
      ListTile(title: Text("Released"), subtitle: Text(movie.released),),
      ListTile(title: Text("Runtime"), subtitle: Text(movie.runtime),),
      ListTile(title: Text("Genre"), subtitle: Text(movie.genre),),
      ListTile(title: Text("Director"), subtitle: Text(movie.director),),
      ListTile(title: Text("Actors"), subtitle: Text(movie.actors),),
    ];
  }

  /// API Client経由で取得した映画情報を[MovieDetailModel]に変換し返す。
  /// メソッドに[async]キーワードを付与すると、そのメソッド内で[await]が使える。
  /// JavaScriptのasync/awaitと同じように、[await]は非同期処理が完了するまで、
  /// 次の処理に進まないよう待機する。
  Future<MovieDetailModel> fetchMovie() async {
    String movieJson = await client.fetchMovie(imdbID);
    // 'dart:convert'パッケージのdecodeメソッドを利用し、
    // JSONの文字列をMap<String, dynamic>に変換する。
    return MovieDetailModel.fromJson(json.decode(movieJson));
  }
}