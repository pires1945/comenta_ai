class Movie {
  final int id;
  final String title;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final List<dynamic> genre;
  int countStar;
  int totalUsersAvaliation;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.genre,
    this.countStar = 0,
    this.totalUsersAvaliation = 0,
  });

  setStars(int star) {
    countStar = star;
  }
}
