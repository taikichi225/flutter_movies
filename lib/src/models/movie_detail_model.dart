/// 映画の詳細情報を保持するモデルクラス
class MovieDetailModel {
  String imdbID;
  String title;
  String year;
  String released;
  String runtime;
  String genre;
  String poster;
  String director;
  String actors;

  /// 名前付きコンストラクタ
  /// Dartはコンストラクタに独自に名前を付けられる。
  /// 
  /// 以下のように、インスタンスを生成する。
  /// MovieDetailModel model = MovieDetailModel.fromJson(適切な引数);
  /// 
  /// 外部APIまたはDBから取得したデータをMapに変換し、
  /// fromJsonという名前のコンストラクタでモデルクラスを生成するのが一般的。
  MovieDetailModel.fromJson(Map<String, dynamic> json) {
    // 取得可能な情報が多かったので、今回は一部データに絞りました。
    this.imdbID = json["imdbID"];
    this.title = json["Title"];
    this.year = json["Year"];
    this.released =json["Released"];
    this.runtime = json["Runtime"];
    this.genre = json["Genre"];
    this.poster = json["Poster"];
    this.director = json["Director"];
    this.actors = json["Actors"];
  }
}