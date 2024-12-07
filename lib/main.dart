import 'package:comenta_ai/pages/auth_or_app_page.dart';
import 'package:comenta_ai/pages/home_page.dart';
import 'package:comenta_ai/pages/movie_detail.dart';
import 'package:comenta_ai/pages/my_reviews.dart';
import 'package:comenta_ai/pages/reviewForm.dart';
import 'package:comenta_ai/utils/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.black45,
          onSecondary: Colors.black,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.AUTHORHOME: (context) => AuthOrAppPage(),
        AppRoutes.HOME: (context) => HomePage(),
        AppRoutes.MOVIEDETAIL: (context) => MovieDetail(),
        AppRoutes.REVIEWFORM: (context) => Reviewform(),
        AppRoutes.MYREVIEWS: (context) => MyReviews(),
      },
    );
  }
}
