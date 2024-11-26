import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:comenta_ai/core/service/movie/movie_service.dart';
import 'package:comenta_ai/pages/auth_page.dart';
import 'package:comenta_ai/pages/home_page.dart';
import 'package:comenta_ai/pages/movie_detail.dart';
import 'package:comenta_ai/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => MovieService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: Color.fromARGB(255, 18, 6, 34),
            onPrimary: Colors.white,
            secondary: Colors.black45,
            onSecondary: const Color.fromARGB(255, 42, 41, 87),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (context) => const AuthPage(),
          AppRoutes.MOVIEDETAIL: (context) => const MovieDetail(),
        },
      ),
    );
  }
}
