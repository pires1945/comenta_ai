import 'package:comenta_ai/components/icons_Star.dart';
import 'package:comenta_ai/components/star_mini_item.dart';
import 'package:flutter/material.dart';

class StarsMini extends StatelessWidget {
  final double mediaStars;
  const StarsMini(this.mediaStars, {super.key});

  @override
  Widget build(BuildContext context) {
    if (mediaStars > 0 && mediaStars < 1) {
      return const HalfStar();
    } else if (mediaStars >= 1 && mediaStars < 1.5) {
      return const IconStar();
    } else if (mediaStars >= 1.5 && mediaStars < 2) {
      return const Row(
        children: [
          StarMiniItem(),
          HalfstarMiniItem(),
        ],
      );
    } else if (mediaStars >= 2 && mediaStars < 2.5) {
      return const Row(
        children: [
          StarMiniItem(),
          StarMiniItem(),
        ],
      );
    } else if (mediaStars >= 2.5 && mediaStars < 3) {
      return const Row(
        children: [
          StarMiniItem(),
          StarMiniItem(),
          HalfstarMiniItem(),
        ],
      );
    } else if (mediaStars >= 3 && mediaStars < 3.5) {
      return const Row(
        children: [
          StarMiniItem(),
          StarMiniItem(),
          StarMiniItem(),
        ],
      );
    } else if (mediaStars >= 3.5 && mediaStars < 4) {
      return const Row(
        children: [
          StarMiniItem(),
          StarMiniItem(),
          StarMiniItem(),
          HalfstarMiniItem(),
        ],
      );
    } else if (mediaStars >= 4 && mediaStars < 4.5) {
      return const Row(
        children: [
          StarMiniItem(),
          StarMiniItem(),
          StarMiniItem(),
          StarMiniItem(),
        ],
      );
    } else if (mediaStars >= 4.5 && mediaStars < 5) {
      return const Row(
        children: [
          StarMiniItem(),
          StarMiniItem(),
          StarMiniItem(),
          StarMiniItem(),
          HalfstarMiniItem(),
        ],
      );
    } else if (mediaStars >= 5) {
      return const Row(
        children: [
          StarMiniItem(),
          StarMiniItem(),
          StarMiniItem(),
          StarMiniItem(),
          StarMiniItem(),
        ],
      );
    }

    return const Text(
      'Sem avaliações',
      style: TextStyle(color: Colors.white, fontSize: 17),
    );
  }
}
