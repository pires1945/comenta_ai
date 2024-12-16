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
    const baseUrlImage = 'https://image.tmdb.org/t/p/w220_and_h330_face';

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
            leading: Container(
              child: Image.network(
                baseUrlImage + review.movieImageUrl,
                fit: BoxFit.cover,
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
