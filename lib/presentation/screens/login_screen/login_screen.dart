import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../home_screen/home_screen.dart';
import 'widgets/custom_text_field.dart';
import '../../../core/di/injection.dart';
import '../../../core/errors/app_exception.dart';
import '../../../data/models/sesion.dart';
import '../../../services/authentication_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationService _service = sl<AuthenticationService>();
  bool _ocultarPassword = true;
  bool _cargando = false;
  String _error = '';

  // pide a la API iniciar sesion
  void _iniciarSesion() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    setState(() {
      _error = '';
      _cargando = true;
    });

    try {
      Sesion sesion = await _service.iniciarSesion(email, password);

      if (!mounted) return;

      //si todo esta bien, pasamos a la pantalla de inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            nombreUsuario: sesion.nombre,
            email: sesion.correo,
            rol: sesion.rol,
          ),
        ),
      );
    } on AppException catch (e) {
      setState(() {
        _error = e.mensaje;
        _cargando = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Ocurrio un error inesperado';
        _cargando = false;
      });
    }
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
                Text(
                  'Purísimo Café',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTema.texto(context)),
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
                    onPressed: _cargando ? null : _iniciarSesion,
                    child: _cargando
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Iniciar sesión'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
