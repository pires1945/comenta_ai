import 'package:comenta_ai/components/review_item.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:comenta_ai/core/service/review/reviewService.dart';
import 'package:flutter/material.dart';

class AllReviews extends StatefulWidget {
  const AllReviews({super.key});

  @override
  State<AllReviews> createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  final user = AuthService().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas Reviews'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: StreamBuilder<List<Review>>(
          stream: ReviewService().reviewStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Sem dados'),
              );
            } else {
              final reviews = snapshot.data!.toList();
              return ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) => ReviewItem(
                  review: reviews[index],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
