import 'dart:convert';

import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieService with ChangeNotifier {
  List<Movie> _movies = [];
  int page = 1;

  List<Movie> get movies => [..._movies];

  Future<void> loadMovies() async {
    _movies.clear();
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&language=pt-BR&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_watch_monetization_types=flatrate'));
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> results = data['results'];
    print(results);

    results.forEach((element) {
      _movies.add(Movie(
        id: element['id'],
        title: element['title'],
        overview: element['overview'],
        image: element['poster_path'],
        backdrop_path: element['backdrop_path'] ?? '',
        genre: element['genre_ids'],
      ));
    });
    notifyListeners();
  }
}
