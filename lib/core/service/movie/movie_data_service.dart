import 'dart:async';
import 'dart:convert';
import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:comenta_ai/utils/constants.dart';
import 'package:comenta_ai/utils/genre_list.dart';
import 'package:http/http.dart' as http;

class MovieDataService implements MovieService {
  int page = 1;
  static final List<Movie> _movies = [];
  static final List<Movie> _searchResults = [];
  static final List<Movie> _popularMovies = [];
  static final List<Movie> _genreResults = [];
  static MultiStreamController<List<Movie>>? _popularController;
  static MultiStreamController<List<Movie>>? _searchController;
  static MultiStreamController<List<Movie>>? _controller;
  static MultiStreamController<List<Movie>>? _genreController;
  DateTime date = DateTime.now();

  //String baseUrlImage = 'https://image.tmdb.org/t/p/w220_and_h330_face';

  //loadMovies
  static final _movieStream = Stream<List<Movie>>.multi(
    (controller) {
      _controller = controller;
      controller.add(_movies);
    },
  );

  @override
  Stream<List<Movie>> movieStream() {
    return _movieStream;
  }

  @override
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
        overview: element['overview'] ?? '',
        backdropPath: element['backdrop_path'] ?? ' ',
        posterPath: element['poster_path'] ?? ' ',
        genre: element['genre_ids'],
      ));
    });
    _controller?.add(_movies);
  }

  //searchMovies
  static final _searchStream = Stream<List<Movie>>.multi(
    (controller) {
      _searchController = controller;
      controller.add(_searchResults);
    },
  );

  @override
  Stream<List<Movie>> searchStream() {
    return _searchStream;
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
        overview: element['overview'] ?? '',
        backdropPath: element['backdrop_path'] ?? ' ',
        posterPath: element['poster_path'] ?? ' ',
        genre: element['genre_ids'],
      ));
    });

    _searchController?.add(_searchResults);
  }

  static final _genreStream = Stream<List<Movie>>.multi((controller) {
    _genreController = controller;
    controller.add(_genreResults);
  });

  @override
  Stream<List<Movie>> genreStream() {
    return _genreStream;
  }

  @override
  Future<void> genreMovie(String genre) async {
    _genreResults.clear();
    print(genre);

    String key = GenreList.genreList.keys
        .firstWhere((k) => GenreList.genreList[k] == genre);

    print(key);

    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&language=pt-BR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate&with_genres=${key}'));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> results = data['results'];

    print(results);

    results.forEach((element) {
      _genreResults.add(Movie(
        id: element['id'],
        title: element['title'],
        overview: element['overview'] ?? ' ',
        backdropPath: element['backdrop_path'] ?? ' ',
        posterPath: element['poster_path'] ?? ' ',
        genre: element['genre_ids'],
      ));
    });

    _genreController?.add(_genreResults);
  }

  //popularMovies

  static final _popularStream = Stream<List<Movie>>.multi(
    (controller) {
      _popularController = controller;
      controller.add(_popularMovies);
    },
  );

  @override
  Stream<List<Movie>> popularStream() {
    return _popularStream;
  }

  @override
  Future<void> popularMovie() async {
    _popularMovies.clear();
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=38a4de8b418e2d5031191eeb56ecc46a&language=pt-BR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1'));
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> results = data['results'];

    results.forEach((element) {
      _popularMovies.add(Movie(
        id: element['id'],
        title: element['title'],
        overview: element['overview'],
        backdropPath: element['backdrop_path'] ?? ' ',
        posterPath: element['poster_path'] ?? ' ',
        genre: element['genre_ids'],
      ));
    });

    _popularController?.add(_popularMovies);
  }

  //Em cartaz

  //'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apiKey}&language=pt-BR&sort_by=popularity.desc&include_adult=false&include_video=false&page=${page}&with_release_type=2|3&region=BR'
}
