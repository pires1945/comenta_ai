import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isSignup = false;
  bool _isLoading = false;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _switchAuthMode() {
    setState(() {
      _isSignup = !_isSignup;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formkey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formkey.currentState?.save();

    AuthService auth = Provider.of(context, listen: false);

    try {
      if (!_isSignup) {
        await auth.signin(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } catch (error) {
      _showErrorDialog(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 9,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _isSignup ? deviceSize.height * 0.4 : deviceSize.height * 0.3,
        width: deviceSize.width * 0.8,
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => _authData['email'] = newValue ?? '',
                validator: (value) {
                  final email = value ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Informe um email válido';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => _authData['password'] = newValue ?? '',
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  final password = value ?? '';
                  if (password.trim().isEmpty || password.length < 5) {
                    return 'A Senha deve ser maior do que 5 caracteres';
                  } else {
                    return null;
                  }
                },
              ),
              if (_isSignup)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirme a Senha'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) {},
                  obscureText: true,
                  validator: _isSignup == false
                      ? null
                      : (value) {
                          final password = value ?? '';
                          if (password != _passwordController.text) {
                            return 'As senhas não conferem';
                          } else {
                            return null;
                          }
                        },
                ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 8,
                          )),
                      onPressed: _submit,
                      child: Text(
                        _isSignup ? 'Registrar' : 'Entrar',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ),
              Spacer(),
              TextButton(
                  onPressed: _switchAuthMode,
                  child:
                      Text(_isSignup ? 'Registrar-se' : 'Já possuo uma conta')),
            ],
          ),
        ),
      ),
    );
  }
}
