import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import '../home_screen/home_screen.dart';

/// Usuario de prueba para poder iniciar sesión mientras no hay
/// backend. Es la ÚNICA información simulada que se conserva en el
/// proyecto.
class _MockUser {
  final String nombre;
  final String email;
  final String password;
  final String rol; // 'Administrador' o 'Cajero'

  const _MockUser({
    required this.nombre,
    required this.email,
    required this.password,
    required this.rol,
  });
}

const List<_MockUser> _usuariosDePrueba = [
  _MockUser(
    nombre: 'Diana García',
    email: 'admin@purisimocafe.com',
    password: 'admin123',
    rol: 'Administrador',
  ),
  _MockUser(
    nombre: 'Steven Hernández',
    email: 'cajero@purisimocafe.com',
    password: 'cajero123',
    rol: 'Cajero',
  ),
];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa tu correo electrónico';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Ingresa un correo válido';
    }
    return null;
  }

  String? _validarPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa tu contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simula una pequeña espera, como si consultara un servidor real.
    await Future.delayed(const Duration(milliseconds: 800));

    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text;

    final coincidencias =
        _usuariosDePrueba.where((u) => u.email.toLowerCase() == email);

    setState(() => _isLoading = false);

    if (coincidencias.isEmpty || coincidencias.first.password != password) {
      setState(() {
        _errorMessage = 'Correo o contraseña incorrectos. Verifica tus datos.';
      });
      return;
    }

    final usuario = coincidencias.first;
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeScreen(nombreUsuario: usuario.nombre, rol: usuario.rol),
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
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.local_cafe_rounded,
                      size: 56,
                      color: AppColors.cafeGold,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Purísimo Café',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Inicia sesión para continuar',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),

                    CustomTextField(
                      controller: _emailController,
                      label: 'Correo electrónico',
                      hint: 'nombre@purisimocafe.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validarEmail,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _passwordController,
                      label: 'Contraseña',
                      icon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      validator: _validarPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),

                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.danger.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.danger.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline,
                                color: AppColors.danger, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  color: AppColors.danger,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Iniciar sesión',
                      isLoading: _isLoading,
                      onPressed: _handleLogin,
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'Usuarios de prueba:\n'
                      'admin@purisimocafe.com / admin123\n'
                      'cajero@purisimocafe.com / cajero123',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
