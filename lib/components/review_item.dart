import 'package:comenta_ai/core/models/review.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({
    required this.review,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Theme.of(context).colorScheme.tertiary,
          child: ListTile(
            title: Text(
              review.movieTitle,
              style: const TextStyle(
                  color: Color.fromARGB(255, 211, 195, 48), fontSize: 17),
            ),
            subtitle: Text(
              review.review,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(review.userImageUrl),
              ),
            ),
            trailing: Container(
              child: Text(
                review.avaliation > 1
                    ? '${review.avaliation.toString()} estrelas'
                    : '${review.avaliation.toString()} estrela',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
