import 'dart:async';
import 'dart:math';

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
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width - 20,
              maxHeight: 250,
            ),
            child: CarouselView(
              controller: _carouselController,
              itemExtent: 270,
              itemSnapping: true,
              children: images,
            ),
          ),
        ),
      ),
    );
  }
}
