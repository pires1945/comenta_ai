import 'package:flutter/material.dart';

class Movie with ChangeNotifier {
  final int id;
  final String title;
  final String overview;
  final String image;
  final String backdrop_path;
  final List<dynamic> genre;
  int countStar;
  int totalUsersAvaliation;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.image,
    required this.backdrop_path,
    required this.genre,
    this.countStar = 0,
    this.totalUsersAvaliation = 0,
  });

  setStars(int star) {
    countStar = star;
  }
}
