import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_movies/src/movie_list.dart';
import 'package:flutter_movies/src/api/movie_client.dart';
 class MockMovieClient implements MovieClient {
  Future<String> fetchMovies(String searchWord) {
    return Future.value('{"Search":[{"Title":"StarWars:EpisodeIV-ANewHope","Year":"1977","imdbID":"tt0076759","Type":"movie","Poster":""}],"totalResults":"3090","Response":"True"}');
  }
   Future<String> fetchMovie(String id) {
    return Future.value('');
  }
}
 Widget buildTestWidget(Widget widget) {
  return MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(home:widget),
  );
}
 void main() {
  testWidgets("display the search result", (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget(MovieList(client: MockMovieClient(),)));
    
    Finder searchbox = find.byKey(Key("searchForm"));
    await tester.enterText(searchbox, "starwars");
     Finder searchButton = find.byKey(Key("searchButton"));
    await tester.tap(searchButton);
     await tester.pumpAndSettle();
     Finder listTile = find.byType(ListTile);
    expect(listTile, findsOneWidget);
     Finder title = find.text("StarWars:EpisodeIV-ANewHope");
    expect(title, findsOneWidget);
     Finder subtitle = find.text("1977");
    expect(subtitle, findsOneWidget);
   });
}