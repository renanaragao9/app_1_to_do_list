import 'package:flutter/material.dart';
import 'package:project_one/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const FlutterLogo(size: 76),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Nome'
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email'
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Senha'
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        hintText: 'Confirmar Senha'
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _register,
                      child: const Text('Cadastrar')
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Future<void> _register() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      final String? erro = await authService.register(
        email: _emailController.text, 
        password: _passwordController.text, 
        name: _nameController.text
      );
      if (!mounted) return; 
      if (erro != null) {
        final snackBar = SnackBar(
          content: Text(erro),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Navigator.pop(context);
      }
    } else {
      if (!mounted) return; 
      const snackBar = SnackBar(
        content: Text('As senhas não coincidem.'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
