import 'package:comenta_ai/components/icons_Star.dart';
import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  double mediaStars;
  Stars(this.mediaStars, {super.key});

  @override
  Widget build(BuildContext context) {
    if (mediaStars > 0 && mediaStars < 1) {
      return const HalfStar();
    } else if (mediaStars >= 1 && mediaStars < 1.5) {
      return const IconStar();
    } else if (mediaStars >= 1.5 && mediaStars < 2) {
      return const Row(
        children: [
          IconStar(),
          HalfStar(),
        ],
      );
    } else if (mediaStars >= 2 && mediaStars < 2.5) {
      return const Row(
        children: [
          IconStar(),
          IconStar(),
        ],
      );
    } else if (mediaStars >= 2.5 && mediaStars < 3) {
      return const Row(
        children: [
          IconStar(),
          IconStar(),
          HalfStar(),
        ],
      );
    } else if (mediaStars >= 3 && mediaStars < 3.5) {
      return const Row(
        children: [
          IconStar(),
          IconStar(),
          IconStar(),
        ],
      );
    } else if (mediaStars >= 3.5 && mediaStars < 4) {
      return const Row(
        children: [
          IconStar(),
          IconStar(),
          IconStar(),
          HalfStar(),
        ],
      );
    } else if (mediaStars >= 4 && mediaStars < 4.5) {
      return const Row(
        children: [
          IconStar(),
          IconStar(),
          IconStar(),
          IconStar(),
        ],
      );
    } else if (mediaStars >= 4.5 && mediaStars < 5) {
      return const Row(
        children: [
          IconStar(),
          IconStar(),
          IconStar(),
          IconStar(),
          HalfStar(),
        ],
      );
    } else if (mediaStars >= 5) {
      return const Row(
        children: [
          IconStar(),
          IconStar(),
          IconStar(),
          IconStar(),
          IconStar(),
        ],
      );
    }

    return const Text(
      ' Nenhuma avaliação dos usuários ',
      style: TextStyle(color: Colors.white, fontSize: 17),
    );
  }
}
