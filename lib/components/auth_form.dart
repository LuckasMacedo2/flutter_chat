import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/components/user_image_picker.dart';
import 'package:flutter_chat/core/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void _handleImagePick(File image) {
    _authFormData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    final _isvalid = _formKey.currentState?.validate() ?? false;
    if (!_isvalid) return;

    //if (_authFormData.image == null && _authFormData.isSignUp)
    //  return _showError('Imagem não selecionada');

    widget.onSubmit(_authFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authFormData.isSignUp)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_authFormData.isSignUp)
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _authFormData.name,
                  onChanged: (name) => _authFormData.name = name,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (_name) {
                    final name = _name ?? '';
                    return name.trim().length < 5
                        ? 'Nome deve ter no mínimo 5 caracteres'
                        : null;
                  },
                ),
              TextFormField(
                key: ValueKey('email'),
                initialValue: _authFormData.email,
                onChanged: (email) => _authFormData.email = email,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (_email) {
                  final email = _email ?? '';
                  return !email.contains('@')
                      ? 'E-mail informado é inválido'
                      : null;
                },
              ),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                initialValue: _authFormData.password,
                onChanged: (password) => _authFormData.password = password,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (_password) {
                  final password = _password ?? '';
                  return password.length < 6
                      ? 'Senha deve ter no mínimo 6 caracteres'
                      : null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_authFormData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _authFormData.toggleAuthMode();
                  });
                },
                child: Text(_authFormData.isLogin
                    ? 'Criar uma nova conta'
                    : 'Já possui conta?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
