import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../services/authentication_service.dart';
import '../../providers/tema_provider.dart';
import '../../widgets/dialogo_confirmar.dart';
import '../login_screen/login_screen.dart';
import 'widgets/avatar_perfil.dart';
import 'widgets/opcion_perfil.dart';

class PerfilScreen extends StatelessWidget {
  final String nombre;
  final String email;
  final String rol;

  const PerfilScreen({
    super.key,
    required this.nombre,
    required this.email,
    required this.rol,
  });

  void _cerrarSesion(BuildContext context) async {
    bool si = await confirmar(context, '¿Deseas cerrar sesión?');

    if (si && context.mounted) {
      // Borramos el token de la sesión
      sl<AuthenticationService>().cerrarSesion();

      // Volvemos al login y borramos las pantallas anteriores
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (ruta) => false,
      );
    }
  }

  // Título pequeño de cada sección
  Widget _titulo(BuildContext context, String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppTema.textoSuave(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = context.watch<TemaProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(child: AvatarPerfil(nombre: nombre, rol: rol)),

          // Datos personales
          _titulo(context, 'DATOS PERSONALES'),
          OpcionPerfil(icono: Icons.email_outlined, texto: email),
          const OpcionPerfil(
            icono: Icons.store_outlined,
            texto: 'Sucursal Masatepe',
          ),

          // Apariencia
          _titulo(context, 'APARIENCIA'),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: Icon(
              tema.modoOscuro
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              color: AppTema.texto(context),
            ),
            title: Text(
              'Modo oscuro',
              style: TextStyle(color: AppTema.texto(context)),
            ),
            activeTrackColor: AppColors.primary,
            value: tema.modoOscuro,
            onChanged: (valor) {
              tema.cambiar(valor);
            },
          ),

          const SizedBox(height: 16),
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
