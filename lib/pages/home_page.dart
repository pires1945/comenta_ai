import 'package:comenta_ai/components/app_drawer.dart';
import 'package:comenta_ai/components/movie_grid.dart';
import 'package:comenta_ai/components/search_item.dart';
import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearch = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleSearch() {
    setState(() {
      _isSearch = !_isSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 70),
              child: Text(
                !_isSearch ? 'Filmes' : 'Buscar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 60),
              child: IconButton(
                onPressed: () {
                  _toggleSearch();
                },
                icon: !_isSearch
                    ? const Icon(
                        Icons.search,
                        size: 36,
                      )
                    : Icon(Icons.cancel_outlined),
              ),
            )
          ],
        ),
        //Text('Olá, ${AuthService().currentUser!.name}'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: AppDrawer(),
      body: !_isSearch ? MovieGrid() : SearchItem(),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      //   unselectedItemColor: Theme.of(context).colorScheme.tertiary,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   items: const [
      //     BottomNavigationBarItem(
      //       label: 'Inicio',
      //       icon: Icon(
      //         Icons.home,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Filmes',
      //       icon: Icon(
      //         Icons.movie_creation_outlined,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Busca',
      //       icon: Icon(
      //         Icons.search,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
