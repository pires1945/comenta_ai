class Review {
  String id;
  String userId;
  String userImageUrl;
  String movieTitle;
  int movieId;
  String review;
  int avaliation;
  DateTime date;

  Review({
    required this.id,
    required this.userId,
    required this.userImageUrl,
    required this.movieTitle,
    required this.movieId,
    required this.review,
    required this.avaliation,
    required this.date,
  });
}
