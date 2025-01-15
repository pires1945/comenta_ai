import 'package:flutter/material.dart';

class Movie with ChangeNotifier {
  final int id;
  final String title;
  final String overview;
  final String image;
  final String backdrop_path;
  final List<dynamic> genre;
  final DateTime release_date;
  int countStar;
  int totalUsersAvaliation;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.image,
    required this.backdrop_path,
    required this.genre,
    required this.release_date,
    this.countStar = 0,
    this.totalUsersAvaliation = 0,
  });

  setStars(int star) {
    countStar = star;
  }
}
