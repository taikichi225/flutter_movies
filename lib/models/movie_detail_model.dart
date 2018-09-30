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

  MovieDetailModel.fromJson(Map<String, dynamic> json) {
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