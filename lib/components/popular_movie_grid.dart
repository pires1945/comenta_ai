import 'package:comenta_ai/components/movie_item.dart';
import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:comenta_ai/pages/loading_page.dart';
import 'package:flutter/material.dart';

class PopularMovieGrid extends StatefulWidget {
  const PopularMovieGrid({super.key});

  @override
  State<PopularMovieGrid> createState() => _PopularMovieGridState();
}

class _PopularMovieGridState extends State<PopularMovieGrid> {
  @override
  void initState() {
    super.initState();
    MovieService().popularMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Mais populares'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: StreamBuilder<List<Movie>>(
            stream: MovieService().popularStream(),
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
