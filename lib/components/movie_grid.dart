import 'package:comenta_ai/components/movie_item.dart';
import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:comenta_ai/pages/loading_page.dart';
import 'package:flutter/material.dart';

class MovieGrid extends StatefulWidget {
  const MovieGrid({super.key});

  @override
  State<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  bool isSearch = false;
  final _formKey = GlobalKey<FormState>();
  late String _searchText;

  @override
  void initState() {
    super.initState();
    MovieService().loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: StreamBuilder<List<Movie>>(
          stream: MovieService().movieStream(),
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
    );
  }
}
