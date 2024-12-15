import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/review/review_firebase_service.dart';

abstract class ReviewService {
  Stream<List<Review>> reviewStream();
  Future<Review?> save(Map<String, Object> data);

  factory ReviewService() {
    return ReviewFirebaseService();
  }
}
