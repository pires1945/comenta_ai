import 'package:comenta_ai/core/service/auth/auth_mock_service.dart';
import 'package:comenta_ai/pages/auth_page.dart';
import 'package:comenta_ai/pages/home_page.dart';
import 'package:comenta_ai/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: AuthMockService().userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return snapshot.hasData ? const HomePage() : const AuthPage();
          }
        },
      ),
    );
  }
}
