import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import './api/omdb_movie_client.dart';
import './api/movie_client.dart';
import './models/movie_detail_model.dart';


class MovieDetail extends StatelessWidget {
  final String imdbID;
  final MovieClient client;

  MovieDetail({Key key, @required this.imdbID, @required this.client}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: FutureBuilder(
        future: _fetchMovie(),
        builder: (BuildContext context, AsyncSnapshot<MovieDetailModel> snapshot) {
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }

          MovieDetailModel movie = snapshot.data;
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Hero(tag:movie.imdbID, child: Image.network(movie.poster, fit: BoxFit.contain,),),
                    ListTile(title: Text("Title"), subtitle: Text(movie.title),),
                    ListTile(title: Text("Year"), subtitle: Text(movie.year),),
                    ListTile(title: Text("Released"), subtitle: Text(movie.released),),
                    ListTile(title: Text("Runtime"), subtitle: Text(movie.runtime),),
                    ListTile(title: Text("Genre"), subtitle: Text(movie.genre),),
                    ListTile(title: Text("Director"), subtitle: Text(movie.director),),
                    ListTile(title: Text("Actors"), subtitle: Text(movie.actors),),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<MovieDetailModel> _fetchMovie() async {
    String movieJson = await client.fetchMovie(imdbID);
    return MovieDetailModel.fromJson(json.decode(movieJson));
  }
}