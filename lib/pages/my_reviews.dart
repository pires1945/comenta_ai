import 'package:comenta_ai/components/review_item.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:comenta_ai/core/service/review/reviewService.dart';
import 'package:flutter/material.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  final user = AuthService().currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Reviews'),
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
              final reviews = snapshot.data!
                  .where((element) => element.userId == user!.id)
                  .toList()
                  .reversed
                  .toList();
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
