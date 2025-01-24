import 'dart:async';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:comenta_ai/components/app_drawer.dart';
import 'package:comenta_ai/core/service/auth/auth_service.dart';
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
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Colors.white,
            title: Text(auth.currentUser!.name),
          ),
          drawer: AppDrawer(),
          drawerScrimColor: Theme.of(context).colorScheme.tertiary,
          //backgroundColor: Theme.of(context).colorScheme.secondary,
          body: CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.ease,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 2),
              animateToClosest: true,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Text(
                        'text $i',
                        style: TextStyle(fontSize: 16.0),
                      ));
                },
              );
            }).toList(),
          )),
    );
  }
}

// Center(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.sizeOf(context).width - 20,
//               maxHeight: 250,
//             ),
//             child: CarouselView(
//               controller: _carouselController,
//               itemExtent: 270,
//               itemSnapping: true,
//               children: images,
//             ),
//           ),
//         ),