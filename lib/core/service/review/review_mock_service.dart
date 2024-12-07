import 'dart:async';
import 'dart:math';

import 'package:comenta_ai/core/models/app_user.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/review/reviewService.dart';

class ReviewMovkService implements ReviewService {
  static final List<Review> _reviews = [];
  static MultiStreamController<List<Review>>? _controller;

  static final _reviewStream = Stream<List<Review>>.multi(
    (controller) {
      _controller = controller;
      controller.add(_reviews);
    },
  );

  @override
  Stream<List<Review>> reviewStream() {
    return _reviewStream;
  }

  @override
  Future<Review> save(Review review, AppUser user) async {
    final newReview = Review(
      id: Random().nextDouble().toString(),
      userId: user.id,
      userImageUrl: user.imageUrl,
      movieTitle: review.movieTitle,
      movieId: review.movieId,
      review: review.review,
      avaliation: review.avaliation,
      createdAt: review.createdAt,
    );

    _reviews.add(newReview);
    _controller?.add(_reviews.reversed.toList());

    return newReview;
  }
}
