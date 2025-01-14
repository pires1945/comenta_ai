import 'package:comenta_ai/components/movie_item_search.dart';
import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:comenta_ai/pages/loading_page.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String _searchText = '';

  Future<void> _submitSearch() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formKey.currentState?.save();

    await MovieService().searchMovie(_searchText);
  }

  @override
  Widget build(BuildContext context) {
    String label =
        _searchText.isEmpty ? 'Digite o nome do filme...' : _searchText;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: Form(
          key: _formKey,
          child: TextField(
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            decoration: InputDecoration(
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              labelStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w300),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 71, 71, 71),
            ),
            onChanged: (value) {
              _searchText = value;
            },
            onSubmitted: (value) {
              _submitSearch();
            },
          ),
        ),
      ),
      body: StreamBuilder<List<Movie>>(
          stream: MovieService().searchStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum dado encontrado',
                  style: TextStyle(color: Colors.yellow),
                ),
              );
            } else {
              final movies = snapshot.data!;
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: movies.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: MovieItemSearch(
                          movie: movies[index],
                        ),
                      ));
            }
          }),
    );
  }
}
