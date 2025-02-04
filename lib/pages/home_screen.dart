import 'package:carousel_slider/carousel_slider.dart';
import 'package:comenta_ai/components/app_drawer.dart';
import 'package:comenta_ai/components/genre_carousel_item.dart';
import 'package:comenta_ai/components/review_carousel_item.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:comenta_ai/core/service/review/reviewService.dart';
import 'package:comenta_ai/utils/app_routes.dart';
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

    Map<String, int> genreList = {
      "Ação": 28,
      "Aventura": 12,
      "Animação": 16,
      "Comédia": 35,
      "Crime": 80,
      "Documentário": 99,
      "Drama": 18,
      "Família": 10751,
      "Fantasia": 14,
      "História": 36,
      "Terror": 27,
      "Música": 10402,
      "Mistério": 9648,
      "Romance": 10749,
      "Ficção científica": 878,
      "Cinema TV": 10770,
      "Thriller": 53,
      "Guerra": 10752,
      "Faroeste": 37,
    };

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
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
