class MovieModel {
  String title;
  String year;
  String imdbID;
  String type;
  String poster;

  MovieModel(this.title, this.year, this.imdbID, this.type, this.poster);

  MovieModel.fromJson(Map<String, dynamic> json) {
    this.title = json["Title"];
    this.year = json["Year"];
    this.imdbID = json["imdbID"];
    this.type = json["Type"];
    this.poster = json["Poster"];
  }
}