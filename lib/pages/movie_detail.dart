import 'package:comenta_ai/components/stars.dart';
import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/models/review.dart';
import 'package:comenta_ai/core/service/review/reviewService.dart';
import 'package:comenta_ai/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({super.key});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    const baseUrlImage = 'https://image.tmdb.org/t/p/w220_and_h330_face';
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(
          movie.title,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Image.network(
                  baseUrlImage + movie.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Avaliação dos usuários',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StreamBuilder<List<Review>>(
                        stream: ReviewService().reviewStream(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('Sem avaliações');
                          } else {
                            var totalStarsMovie = 0;
                            final _reviews = snapshot.data;
                            final review = _reviews!
                                .where((element) => element.movieId == movie.id)
                                .toList();

                            review.forEach((element) =>
                                totalStarsMovie += element.avaliation);

                            var mediaStarMovie =
                                totalStarsMovie / review.length;
                            return Stars();
                          }
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.REVIEWFORM);
                        },
                        icon: Icon(
                          Icons.reviews,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            movie.overview,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
