import 'package:comenta_ai/components/stars_mini.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:flutter/material.dart';

class ReviewCarouselItem extends StatelessWidget {
  final Review review;
  const ReviewCarouselItem(this.review, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(review.movieTitle,
                style: const TextStyle(color: Colors.yellow, fontSize: 20)),
            const SizedBox(height: 6),
            StarsMini(double.parse(review.avaliation.toString())),
            const SizedBox(height: 6),
            Expanded(
              child: Text(review.review,
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
