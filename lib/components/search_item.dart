import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:comenta_ai/utils/app_routes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchItem extends StatelessWidget {
  SearchItem({super.key});

  final _formKey = GlobalKey<FormState>();
  late String _searchText;

  Future<void> _submitSearch() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formKey.currentState?.save();

    await MovieService().searchMovie(_searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          cursorColor: Colors.white,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 71, 71, 71),
            suffixIcon: IconButton(
              onPressed: () {
                _submitSearch();
                Navigator.of(context).pushNamed(AppRoutes.HOME);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          onSaved: (newValue) => _searchText = newValue as String,
        ),
      ),
    );
  }
}
