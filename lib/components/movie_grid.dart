import 'package:comenta_ai/components/movie_item.dart';
import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieGrid extends StatefulWidget {
  const MovieGrid({super.key});

  @override
  State<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieService>(context);
    final List<Movie> loadMovies = provider.movies;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 250,
          ),
          itemCount: loadMovies.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: loadMovies[index],
            child: MovieItem(loadMovies[index]),
          ),
        ),
      ),
    );
  }
}
