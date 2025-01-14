import 'dart:async';
import 'dart:convert';
import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:comenta_ai/utils/constants.dart';
import 'package:http/http.dart' as http;

class MovieDataService implements MovieService {
  int page = 1;
  static final List<Movie> _movies = [];
  static final List<Movie> _searchResults = [];
  static MultiStreamController<List<Movie>>? _searchController;
  static MultiStreamController<List<Movie>>? _controller;

  static final _movieStream = Stream<List<Movie>>.multi(
    (controller) {
      _controller = controller;
      controller.add(_movies);
    },
  );

  static final _searchStream = Stream<List<Movie>>.multi(
    (controller) {
      _searchController = controller;
      controller.add(_searchResults);
    },
  );

  @override
  Stream<List<Movie>> movieStream() {
    return _movieStream;
  }

  @override
  Stream<List<Movie>> searchStream() {
    return _searchStream;
  }

  Future<void> loadMovies() async {
    _movies.clear();
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&language=pt-BR&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_watch_monetization_types=flatrate'));
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> results = data['results'];

    results.forEach((element) {
      _movies.add(Movie(
        id: element['id'],
        title: element['title'],
        overview: element['overview'],
        image: element['poster_path'],
        backdrop_path: element['backdrop_path'] ?? '',
        genre: element['genre_ids'],
        release_date: DateTime.parse(element['release_date']),
      ));
    });
    _controller?.add(_movies);
  }

  @override
  Future<void> searchMovie(String query) async {
    _searchResults.clear();
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}&language=pt-BR&query=${query}&page=1&include_adult=false'));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> results = data['results'];

    results.forEach((element) {
      _searchResults.add(Movie(
        id: element['id'],
        title: element['title'],
        overview: element['overview'],
        image: element['poster_path'] ?? '',
        backdrop_path: element['backdrop_path'] ?? '',
        genre: element['genre_ids'],
        release_date: DateTime.parse(element['release_date']),
      ));
    });

    _searchController?.add(_searchResults);
  }
}

// https://api.themoviedb.org/3/search/movie?api_key=38a4de8b418e2d5031191eeb56ecc46a&language=pt-BR&query=rambo&page=1&include_adult=false