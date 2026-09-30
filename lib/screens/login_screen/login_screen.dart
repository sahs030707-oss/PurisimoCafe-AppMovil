import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../home_screen/home_screen.dart';
import 'widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _ocultarPassword = true;
  String _error = '';

  // Revisa el correo y la contraseña (usuarios de prueba)
  void _iniciarSesion() {
    String email = _emailController.text.trim().toLowerCase();
    String password = _passwordController.text;
    String nombre = '';
    String rol = '';

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _error = 'Completa todos los campos';
      });
      return;
    }

    if (email == 'admin@purisimocafe.com' && password == 'admin123') {
      nombre = 'Steven Hernandez';
      rol = 'Administrador';
    } else if (email == 'cajero@purisimocafe.com' && password == 'cajero123') {
      nombre = 'Yaoska Nicaragua';
      rol = 'Cajero';
    }

    if (nombre == '') {
      setState(() {
        _error = 'Correo o contraseña incorrectos';
      });
      return;
    }

    // Si todo está bien, pasamos a la pantalla de inicio
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomeScreen(nombreUsuario: nombre, email: email, rol: rol),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.local_cafe_rounded,
                    size: 56, color: AppColors.primary),
                const SizedBox(height: 16),
                const Text(
                  'Purísimo Café',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray900),
                ),
                const SizedBox(height: 4),
                const Text('Inicia sesión para continuar'),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _emailController,
                  label: 'Correo electrónico',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Contraseña',
                  icon: Icons.lock_outline,
                  obscureText: _ocultarPassword,
                  suffixIcon: IconButton(
                    icon: Icon(_ocultarPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () {
                      setState(() {
                        _ocultarPassword = !_ocultarPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Solo se muestra si hay un error
                if (_error != '')
                  Text(_error, style: const TextStyle(color: AppColors.error)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _iniciarSesion,
                    child: const Text('Iniciar sesión'),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Usuarios de prueba:\n'
                  'admin@purisimocafe.com / admin123\n'
                  'cajero@purisimocafe.com / cajero123',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.gray700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
