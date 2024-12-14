import 'dart:io';

import 'package:comenta_ai/components/user_image_picker.dart';
import 'package:comenta_ai/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
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
    if (!isValid) return;

    //if (_formData.image == null && _formData.isSignup) {
    //   return _showErrorDialog("image não selecionada");
    //}

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 9,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _formData.isSignup
            ? deviceSize.height * 0.65
            : deviceSize.height * 0.35,
        width: deviceSize.width * 0.8,
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePicker(onImagePick: _handleImagePick),
              if (_formData.isSignup)
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => _formData.name = value,
                  validator: (value) {
                    final name = value ?? '';
                    if (name.length < 3) {
                      return 'O nome deve conter no mínimo 3 letras';
                    } else {
                      return null;
                    }
                  },
                ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _formData.email = value,
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
                obscureText: true,
                controller: _passwordController,
                onChanged: (value) => _formData.password = value,
                validator: (value) {
                  final password = value ?? '';
                  if (password.trim().isEmpty || password.length < 5) {
                    return 'A Senha deve ser maior do que 5 caracteres';
                  } else {
                    return null;
                  }
                },
              ),
              if (_formData.isSignup)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirme a Senha'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) {},
                  obscureText: true,
                  validator: _formData.isSignup == false
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    )),
                onPressed: _submit,
                child: Text(
                  _formData.isSignup ? 'Registrar' : 'Entrar',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                  ),
                ),
              ),
              Spacer(),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _formData.toggleAuthMode();
                    });
                  },
                  child: Text(_formData.isSignup
                      ? 'Já possuo uma conta'
                      : 'Registrar-se')),
            ],
          ),
        ),
      ),
    );
  }
}
