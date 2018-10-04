import 'dart:convert';
import 'package:flutter/material.dart';
import './models/movie_model.dart';
import './api/omdb_movie_client.dart';
import './models/movie_models_factory.dart';
import './movie_detail.dart';

/// 映画検索・リスト画面
class MovieList extends StatefulWidget {
  final MovieClient client;

  MovieList({
    Key key,
    // テストしやすくするため、MovieClientを外部から注入する。
    @required this.client,
  }) : super(key: key);

  // StatefulWidgetはcreateStateメソッドを実装する必要がある。
  _MovieListState createState() => _MovieListState();
}

/// MovieListの状態を実際に持つクラス
class _MovieListState extends State<MovieList> {
  // GlobalKeyは、ウィジェットツリー内でウィジェットを特定するために用いられる。
  // 今回の場合、FormStateを特定し、そのFormStateが保持するフォームの入力内容を取得するために定義している。
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List _movies = [];
  String _searchWord = "";

  /// 画面に表示されるウィジェットを返す。 
  /// [State]は必ず[Widget]を返す[build]メソッドを実装しなければならない。
  Widget build(BuildContext context) {
    // Scaffoldは、material designのレイアウトを作るときの雛形を提供してくれる。
    return Scaffold(
      // appBarに、アプリケーションバーの実装を設定する。
      appBar: AppBar(
        title: Text("Movies"),
      ),
      // bodyに、アプリケーションのメインコンテンツの実装を設定する。
      body: Column(
        children: <Widget>[
          // buildメソッドの見通しをよくするため、別メソッドに切り出し。
          buildSearch(),
          buildList(),
        ],
      ),
    );
  }

  /// 独自定義した検索ボックス[Widget]を返す。
  Widget buildSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Form(
        // GlobalKeyを登録することで、_formKey経由でFormウィジェットにアクセスできる。
        key: _formKey,
        child: Row(
          children: <Widget>[
            // Expandedによって、スペースがあるだけ子ウィジェットの横幅を伸ばす。
            Expanded(
              // 入力フォーム
              child: TextFormField(
                // テスト中に入力フォームウィジェットを特定するため、keyを設定する。
                key: Key("searchForm"),
                decoration: InputDecoration(
                  labelText: "Movie Title",
                ),
                // バリデーションの処理を設定する。
                validator: (String value) => value.isEmpty ? "Enter movie title" : null,
                // saveメソッドが呼ばれた際に、実行される処理を設定する。
                onSaved: (String value) => this._searchWord = value,
              ),
            ),
            // 検索ボタンウィジェットを定義する。
            IconButton(
              // テスト中に入力フォームウィジェットを特定するため、keyを設定する。
              key: Key("searchButton"),
              icon: Icon(Icons.search),
              // ボタンが欧化されたときに実行される処理を定義する。
              onPressed: () {
                // _formKey経由でFormのvalidateメソッドを呼び出す。
                // TextFormFieldのvalidatorで登録していた処理が呼び出される。
                if(_formKey.currentState.validate()) {
                  // _formKey経由でFormのsaveメソッドを呼び出す。
                  // TextFormFieldのonSavedで登録していた処理が呼び出される。
                  _formKey.currentState.save();
                  // widget変数経由でStatefulWidgetのインスタンス変数にアクセスできる。
                  MovieClient client = widget.client;
                  client.fetchMovies(_searchWord).then((response) {
                    List<MovieModel> movies = MovieModelsFactory.create(json.decode(response));
                    // setStateメソッドを呼び出すと再びbuildメソッドが呼び出され、新たな状態をもとに再描画される。
                    setState(() {
                      _movies = movies;
                    });
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  /// 検索結果リスト[Widget]を返す。
  Widget buildList() {
    return Expanded(
      child: ListView.builder(
        // _moviesの要素の数だけitemBuilderを実行する。
        itemCount: _movies.length,
        // 描画するウィジェットを返すメソッドを設定する。
        // ループのインデックスを渡せるので、それをもとに_moviesにアクセスする。
        itemBuilder: (BuildContext context, int index) {
          MovieModel movie = _movies[index];

          // リストの要素を定義する。
          return ListTile(
            // Heroで画面をまたいだアニメーションを定義する。タグでウィジェットを特定する。
            leading: Hero(tag:movie.imdbID, child: Image.network(movie.poster, height: 65.0, width: 50.0,),),
            title: Text(movie.title),
            subtitle: Text(movie.year),
            // リストの要素がタップされた際の処理を設定する。
            onTap: () {
              // ofメソッドで、このウィジェットツリー上にあるNavigatorインスタンスを返す。
              // main.dartのMaterialAppウィジェットの内部でインスタンスが登録されている。
              // Navigatorのpushメソッドで画面を遷移する。
              Navigator.of(context).push(
                // Material Designに則った方法で画面遷移する。
                MaterialPageRoute(
                  builder: (BuildContext context) => MovieDetail(imdbID: movie.imdbID, client: OmdbMovieClient())
                )
              );
            },
          );
        },
      )
    );
  }
}