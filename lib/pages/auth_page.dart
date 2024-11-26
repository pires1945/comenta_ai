import 'package:comenta_ai/components/auth_form.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 18, 6, 34),
                  Color.fromARGB(255, 30, 11, 53),
                  Color.fromARGB(255, 40, 20, 65),
                  Color.fromARGB(255, 55, 41, 73),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SizedBox(),
          Center(child: AuthForm()),
        ],
      ),
    );
  }
}
