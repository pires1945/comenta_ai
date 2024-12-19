import 'package:comenta_ai/components/movie_item.dart';
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
    print(_searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Buscar'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 71, 71, 71),
                    suffixIcon: IconButton(
                      onPressed: _submitSearch,
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 36,
                      ),
                    ),
                  ),
                  onChanged: (value) => _searchText = value,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
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
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) =>
                          MovieItem(snapshot.data![index]),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
