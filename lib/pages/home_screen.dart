import 'package:carousel_slider/carousel_slider.dart';
import 'package:comenta_ai/components/app_drawer.dart';
import 'package:comenta_ai/components/review_carousel_item.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:comenta_ai/core/service/review/reviewService.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _carouselController = CarouselController(initialItem: 3);

  final images = List.generate(
    10,
    (index) => Hero(
      tag: 'image-$index',
      child: Image.network(
        'https://picsum.photos/seed/${index * 7}/350/250',
        fit: BoxFit.cover,
      ),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _carouselController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder<List<Review>>(
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
                  height: MediaQuery.of(context).size.height * 0.25,
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
    );
  }
}

// CarouselSlider(
//           options: CarouselOptions(
//             height: 200.0,
//             aspectRatio: 16 / 9,
//             viewportFraction: 0.8,
//             enableInfiniteScroll: true,
//             autoPlayCurve: Curves.ease,
//             enlargeCenterPage: true,
//             enlargeFactor: 0.3,
//             autoPlay: true,
//             autoPlayAnimationDuration: Duration(seconds: 2),
//             animateToClosest: true,
//           ),
//           items: [1, 2, 3, 4, 5].map((i) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Container(
//                     width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.symmetric(horizontal: 5.0),
//                     decoration: BoxDecoration(color: Colors.amber),
//                     child: Text(
//                       'text $i',
//                       style: TextStyle(fontSize: 16.0),
//                     ));
//               },
//             );
//           }).toList(),
//         ),