import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_movies/src/movie_detail.dart';
import 'package:flutter_movies/src/api/movie_client.dart';
 class MockMovieClient implements MovieClient {
  Future<String> fetchMovies(String searchWord) {
    return Future.value("");
  }
   Future<String> fetchMovie(String id) {
    return Future.value('{"Title":"StarWars:EpisodeVI-ReturnoftheJedi","Year":"1983","Released":"25May1983","Runtime":"131min","Genre":"Action,Adventure,Fantasy","Director":"RichardMarquand","Actors":"MarkHamill,HarrisonFord,CarrieFisher,BillyDeeWilliams","Poster":"","imdbID":"tt0086190"}');
  }
}
 Widget buildTestWidget(Widget widget) {
  return MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(home:widget),
  );
}
 void main() {
  testWidgets("loading screen has displayed", (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget(MovieDetail(imdbID: "1", client: MockMovieClient(),)));
     Finder loading = find.byType(CircularProgressIndicator);
    expect(loading, findsOneWidget);
  });
  
  testWidgets("display the movie detail", (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget(MovieDetail(imdbID: "1", client: MockMovieClient(),)));
    await tester.pumpAndSettle();
     Finder loaded = find.byType(CircularProgressIndicator);
    expect(loaded, findsNothing);
     Finder title = find.text("StarWars:EpisodeVI-ReturnoftheJedi");
    Finder year = find.text("1983");
    Finder released = find.text("25May1983");
    Finder runtime = find.text("131min");
    Finder genre = find.text("Action,Adventure,Fantasy");
    Finder director = find.text("RichardMarquand");
    Finder actors = find.text("MarkHamill,HarrisonFord,CarrieFisher,BillyDeeWilliams");
    
    expect(title, findsOneWidget);
    expect(year, findsOneWidget);
    expect(released, findsOneWidget);
    expect(runtime, findsOneWidget);
    expect(genre, findsOneWidget);
    expect(director, findsOneWidget);
    expect(actors, findsOneWidget);
  });
}