import 'package:comenta_ai/components/app_drawer.dart';
import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        title: Text(auth.currentUser!.name),
      ),
      drawer: AppDrawer(),
      drawerScrimColor: Theme.of(context).colorScheme.tertiary,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 150),
        child: CarouselView(
          itemExtent: MediaQuery.of(context).size.width * 0.5,
          shrinkExtent: 5,
          itemSnapping: true,
          children: List<Widget>.generate(10, (int index) {
            return Center(
              child: Text('Item $index'),
            );
          }),
        ),
      ),
    );
  }
}
