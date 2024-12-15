import 'package:flutter/material.dart';

class IconStar extends StatelessWidget {
  const IconStar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.star,
      color: Colors.yellow,
      size: 30,
    );
  }
}

class HalfStar extends StatelessWidget {
  const HalfStar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.star_half,
      color: Colors.yellow,
      size: 30,
    );
  }
}
