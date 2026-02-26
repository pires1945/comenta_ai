import 'package:carousel_slider/carousel_slider.dart';
import 'package:comenta_ai/components/app_drawer.dart';
import 'package:comenta_ai/components/genre_carousel_item.dart';
import 'package:comenta_ai/components/review_carousel_item.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:comenta_ai/core/service/review/reviewService.dart';
import 'package:comenta_ai/utils/app_routes.dart';
import 'package:comenta_ai/utils/genre_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _carouselController = CarouselController(initialItem: 3);

  @override
  void dispose() {
    super.dispose();
    _carouselController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<String> genreList = [
      '28',
      '12',
      '16',
      '35',
      '80',
      '99',
      '18',
      '10751',
      '14',
      '36',
      '27',
      '10402',
      '9648',
      '10749',
      '878',
      '10770',
      '53',
      '10752',
      '37',
    ];

    final auth = AuthService();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Colors.white,
          title: Text(auth.currentUser!.name),
        ),
        drawer: const AppDrawer(),
        drawerScrimColor: const Color.fromARGB(158, 0, 0, 0),
        //backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Column(
          children: [
            const Text(
              'Avaliação dos usuários',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: height * 0.30,
              child: StreamBuilder<List<Review>>(
                stream: ReviewService().reviewStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final reviewList = snapshot.data;
                    List<Widget> widgets = [];
                    reviewList!
                        .map((e) => widgets.add(ReviewCarouselItem(e)))
                        .toList();
                    return CarouselSlider(
                      items: widgets.map((e) {
                        return Builder(builder: (BuildContext context) {
                          return e;
                        });
                      }).toList(),
                      options: CarouselOptions(
                        height: height * 0.20,
                        aspectRatio: 1 / 5,
                        viewportFraction: 0.52,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.2,
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        animateToClosest: true,
                      ),
                    );
                  }
                },
              ),
            ),
            const Text(
              'Categorias',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.POPULAR);
                  },
                  child: Card(
                    color: Theme.of(context).colorScheme.tertiary,
                    child: SizedBox(
                      height: height * 0.1,
                      width: width * 0.48,
                      child: const Center(
                        child: Text(
                          'Mais bem avaliados',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                          //Aqui irá trazer os mais bem avaliados do aplicativo
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.tertiary,
                  child: SizedBox(
                    height: height * 0.1,
                    width: width * 0.48,
                    child: const Center(
                      child: Text(
                        'Em cartaz',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Builder(
              //criar a lista com os nomes das categorias
              builder: (context) {
                List<Widget> genreWidgets = [];
                genreList
                    .map((e) => genreWidgets.add(
                        GenreCarouselItem(GenreList.genreList[e].toString())))
                    .toList();
                return CarouselSlider(
                  items: genreWidgets.map((e) {
                    return Builder(builder: (BuildContext context) {
                      return e;
                    });
                  }).toList(),
                  options: CarouselOptions(
                    height: height * 0.08,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.3,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: false,
                    enlargeFactor: 0.1,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    animateToClosest: true,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
