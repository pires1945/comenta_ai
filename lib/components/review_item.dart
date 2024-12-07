import 'package:comenta_ai/core/models/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({
    required this.review,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        title: Text(
          review.movieTitle,
          style: TextStyle(color: Colors.yellow),
        ),
        subtitle: Text(review.review),
      ),
    );
  }
}
