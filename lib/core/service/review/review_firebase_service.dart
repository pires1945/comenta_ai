import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/review/reviewService.dart';

class ReviewFirebaseService implements ReviewService {
  @override
  Stream<List<Review>> reviewStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('reviews')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .snapshots();

    return Stream<List<Review>>.multi(
      (controller) {
        snapshots.listen(
          (snapshot) {
            List<Review> list = snapshot.docs.map(
              (e) {
                return e.data();
              },
            ).toList();
            controller.add(list);
          },
        );
      },
    );
  }

  @override
  Future<Review?> save(Map<String, Object> data) async {
    final store = FirebaseFirestore.instance;
    final review = Review(
      id: '',
      userId: data['userId'] as String,
      userImageUrl: data['userImage'] as String,
      movieTitle: data['movieTitle'] as String,
      movieImageUrl: data['movieImageUrl'] as String,
      movieId: data['movieId'] as int,
      review: data['review'] as String,
      avaliation: data['avaliation'] as int,
      date: DateTime.now(),
    );

    final docRef = await store
        .collection('reviews')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(review);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(Review review, SetOptions? options) {
    return {
      'userId': review.userId,
      'userImage': review.userImageUrl,
      'movieTitle': review.movieTitle,
      'movieImageUrl': review.movieImageUrl,
      'movieId': review.movieId,
      'review': review.review,
      'avaliation': review.avaliation,
      'date': review.date.toIso8601String(),
    };
  }

  Review _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? oprtions,
  ) {
    return Review(
      id: doc.id,
      userId: doc['userId'],
      userImageUrl: doc['userImage'],
      movieTitle: doc['movieTitle'],
      movieImageUrl: doc['movieImageUrl'],
      movieId: doc['movieId'],
      review: doc['review'],
      avaliation: doc['avaliation'],
      date: DateTime.parse(doc['date']),
    );
  }
}
