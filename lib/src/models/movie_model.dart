class MovieModel {
  String title;
  String year;
  String imdbID;
  String type;
  String poster;

  MovieModel(this.title, this.year, this.imdbID, this.type, this.poster);

  /// 名前付きコンストラクタ
  /// Dartはコンストラクタに独自に名前を付けられる。
  /// 
  /// 以下のように、インスタンスを生成する。
  /// MovieModel model = MovieModel.fromJson(適切な引数);
  /// 
  /// 外部APIまたはDBから取得したデータをMapに変換し、
  /// fromJsonという名前のコンストラクタでモデルクラスを生成するのが一般的。
  MovieModel.fromJson(Map<String, dynamic> json) {
    this.title = json["Title"];
    this.year = json["Year"];
    this.imdbID = json["imdbID"];
    this.type = json["Type"];
    this.poster = json["Poster"];
  }
}