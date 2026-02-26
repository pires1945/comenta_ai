import 'package:comenta_ai/components/movie_item.dart';
import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:comenta_ai/pages/loading_page.dart';
import 'package:comenta_ai/utils/genre_list.dart';
import 'package:flutter/material.dart';

class GenreMovieGrid extends StatefulWidget {
  const GenreMovieGrid({super.key});

  @override
  State<GenreMovieGrid> createState() => _GenreMovieGridState();
}

class _GenreMovieGridState extends State<GenreMovieGrid> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final String genre = ModalRoute.of(context)!.settings.arguments as String;
      MovieService().genreMovie(genre);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String genre = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(genre),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: StreamBuilder<List<Movie>>(
            stream: MovieService().genreStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Nenhum dado encontrado'),
                );
              } else {
                final movies = snapshot.data!;
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 250,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) =>
                      MovieItem(snapshot.data![index]),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
