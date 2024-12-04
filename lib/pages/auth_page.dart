import 'package:comenta_ai/components/auth_form.dart';
import 'package:comenta_ai/core/models/auth_form_data.dart';
import 'package:comenta_ai/core/service/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> handleSubmit(AuthFormData formData) async {
    try {
      setState(() => _isLoading = true);
      if (formData.isLogin) {
        await AuthMockService().login(
          formData.email,
          formData.password,
        );
      } else {
        await AuthMockService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (error) {
      //tratar erro
    } finally {
      setState(() => _isLoading = true);
    }
  }

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
          const SizedBox(),
          Center(
            child: SingleChildScrollView(
              child: AuthForm(
                onSubmit: handleSubmit,
              ),
            ),
          ),
          if (_isLoading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
