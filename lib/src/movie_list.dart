import 'dart:convert';
import 'package:flutter/material.dart';
import './models/movie_model.dart';
import './api/omdb_movie_client.dart';
import './models/movie_models_factory.dart';
import './movie_detail.dart';

class MovieList extends StatefulWidget {
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List _movies = [];
  String _searchWord = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildSearch(),
          buildList(),
        ],
      ),
    );
  }

  Widget buildSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                key: Key("searchForm"),
                decoration: InputDecoration(
                  labelText: "Movie Title",
                ),
                validator: (String value) => value.isEmpty ? "Enter movie title" : null,
                onSaved: (String value) => this._searchWord = value,
              ),
            ),
            IconButton(
              key: Key("searchButton"),
              icon: Icon(Icons.search),
              onPressed: () {
                if(_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  // TODO inject the instance 'OmdbMovieClient' from constructor
                  OmdbMovieClient client = OmdbMovieClient();
                  client.fetchMovies(_searchWord).then((response) {
                    List<MovieModel> movies = MovieModelsFactory.create(json.decode(response));
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

  Widget buildList() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _movies.length,
        itemBuilder: (BuildContext context, int index) {
          MovieModel movie = _movies[index];

          return ListTile(
            leading: Hero(tag:movie.imdbID, child: Image.network(movie.poster, height: height / 8, width: width / 8,),),
            title: Text(movie.title),
            subtitle: Text(movie.year),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MovieDetail(movie.imdbID)));
            },
          );
        },
      )
    );
  }
}