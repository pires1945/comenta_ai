class Movie {
  final int id;
  final String title;
  final String overview;
  final String image;
  final String backdropPath;
  final List<dynamic> genre;
  int countStar;
  int totalUsersAvaliation;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.image,
    required this.backdropPath,
    required this.genre,
    this.countStar = 0,
    this.totalUsersAvaliation = 0,
  });

  setStars(int star) {
    countStar = star;
  }
}
