import 'package:flutter/material.dart';

class StarMiniItem extends StatelessWidget {
  const StarMiniItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          size: 18,
          color: Colors.yellow,
        ),
      ],
    );
  }
}

class HalfstarMiniItem extends StatelessWidget {
  const HalfstarMiniItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star_half,
          size: 18,
          color: Colors.yellow,
        )
      ],
    );
  }
}
