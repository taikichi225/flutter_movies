import './models/movie_model.dart';

class MovieModelsFactory {
  static List<MovieModel> create(Map<String, dynamic> json) {
    List moviesJson = json["Search"];
    if(moviesJson == null) {
      throw Exception("Json must have the Node named 'Search', which is the type 'List'.");
    }

    List<MovieModel> movies = [];
    for (var i = 0; i < moviesJson.length; i++) {
      MovieModel movie = MovieModel.fromJson(moviesJson[i]);
      movies.add(movie);
    }
    return movies;
  }
}