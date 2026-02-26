import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MovieItemSearch extends StatelessWidget {
  final Movie movie;
  const MovieItemSearch({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const baseUrlImage = 'https://image.tmdb.org/t/p/w220_and_h330_face';

    return GestureDetector(
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        child: ListTile(
          leading: SizedBox(
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            movie.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.MOVIEDETAIL, arguments: movie);
      },
    );
  }
}
