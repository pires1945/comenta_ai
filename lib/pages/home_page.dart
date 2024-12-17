import 'package:comenta_ai/components/app_drawer.dart';
import 'package:comenta_ai/components/movie_grid.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 60),
              child: Text(
                'Filmes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  size: 36,
                ))
          ],
        ),
        //Text('Olá, ${AuthService().currentUser!.name}'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: MovieGrid(),
      drawer: AppDrawer(),
    );
  }
}
