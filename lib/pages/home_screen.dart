import 'package:comenta_ai/components/movie_grid.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Text(
        'HomeScreen',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
