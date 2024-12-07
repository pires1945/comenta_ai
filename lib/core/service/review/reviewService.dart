import 'package:comenta_ai/core/models/app_user.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/review/review_mock_service.dart';

abstract class ReviewService {
  Stream<List<Review>> reviewStream();
  Future<Review> save(Review review, AppUser user);

  factory ReviewService() {
    return ReviewMovkService();
  }
}
