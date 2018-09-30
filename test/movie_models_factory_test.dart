import 'package:test/test.dart';
import 'package:flutter_movies/movie_models_factory.dart';
import 'package:flutter_movies/models/movie_model.dart';

void main() {
  test("Create MovieModels from json data.", () {
    Map<String, dynamic> json = {
      "Search": [
        {
          "Title": "movie1",
          "Year": "2018",
          "imdbID": "movie1",
          "Type": "movie",
          "Poster": "http://example.com",
        },
        {
          "Title": "movie2",
          "Year": "2018",
          "imdbID": "movie2",
          "Type": "movie",
          "Poster": "http://example.com",
        },
      ]
    };
    List<MovieModel> models =  MovieModelsFactory.create(json);
    expect(models.length, 2);
    expect(models[0].title, "movie1");
    expect(models[0].year, "2018");
    expect(models[0].imdbID, "movie1");
    expect(models[0].type, "movie");
    expect(models[0].poster, "http://example.com");
  });
}