import 'package:comenta_ai/components/app_drawer.dart';
import 'package:comenta_ai/components/movie_grid.dart';
import 'package:comenta_ai/pages/all_reviews.dart';
import 'package:comenta_ai/pages/home_screen.dart';
import 'package:comenta_ai/pages/search_page.dart';
import 'package:comenta_ai/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 2;
  // late List<Widget> _widgetOptions;

  @override
  void initState() {
    // _widgetOptions = const [
    //   HomeScreen(),
    //   MovieGrid(),
    //   SearchPage(),
    // ];
    super.initState();
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.SEARCH);
              },
              icon: const Icon(
                Icons.search,
                size: 36,
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
      body: MovieGrid(),
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
