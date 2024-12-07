class Review {
  String id;
  String userId;
  String userImageUrl;
  String movieTitle;
  String movieId;
  String review;
  int avaliation;
  DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.userImageUrl,
    required this.movieTitle,
    required this.movieId,
    required this.review,
    required this.avaliation,
    required this.createdAt,
  });
}
