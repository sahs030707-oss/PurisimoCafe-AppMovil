import 'package:flutter/material.dart';
import '../../widgets/dialogo_confirmar.dart';
import '../login_screen/login_screen.dart';
import 'widgets/avatar_perfil.dart';
import 'widgets/opcion_perfil.dart';

class PerfilScreen extends StatelessWidget {
  final String nombre;
  final String email;
  final String rol;

  const PerfilScreen(
      {super.key,
      required this.nombre,
      required this.email,
      required this.rol});

  // Mensaje para las opciones que todavía no están hechas
  void _proximamente(BuildContext context, String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$texto: próximamente')),
    );
  }

  void _cerrarSesion(BuildContext context) async {
    bool si = await confirmar(context, '¿Deseas cerrar sesión?');
    if (si && context.mounted) {
      // Volvemos al login y borramos las pantallas anteriores
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (ruta) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AvatarPerfil(nombre: nombre, rol: rol),
          const SizedBox(height: 24),
          OpcionPerfil(icono: Icons.email_outlined, texto: email),
          const OpcionPerfil(
              icono: Icons.store_outlined, texto: 'Sucursal Masatepe'),
          OpcionPerfil(
            icono: Icons.edit_outlined,
            texto: 'Editar perfil',
            onTap: () => _proximamente(context, 'Editar perfil'),
          ),
          OpcionPerfil(
            icono: Icons.lock_outline,
            texto: 'Cambiar contraseña',
            onTap: () => _proximamente(context, 'Cambiar contraseña'),
          ),
          OpcionPerfil(
            icono: Icons.logout,
            texto: 'Cerrar sesión',
            esPeligro: true,
            onTap: () => _cerrarSesion(context),
          ),
        ],
      ),
    );
  }
}
