import 'package:flutter/material.dart';

class GenreCarouselItem extends StatelessWidget {
  final int genre;
  const GenreCarouselItem(this.genre, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        color: Theme.of(context).colorScheme.tertiary,
        child: Center(
          child: Text(
            genre.toString(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
