import 'package:comenta_ai/utils/app_routes.dart';
import 'package:flutter/material.dart';

class GenreCarouselItem extends StatelessWidget {
  final String genre;
  const GenreCarouselItem(this.genre, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.GENRE, arguments: genre);
          },
          child: Card(
            color: Theme.of(context).colorScheme.tertiary,
            child: Center(
              child: Text(
                genre,
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
