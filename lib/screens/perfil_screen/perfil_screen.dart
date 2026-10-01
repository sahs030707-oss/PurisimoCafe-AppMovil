import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/dialogo_confirmar.dart';
import '../login_screen/login_screen.dart';
import 'widgets/avatar_perfil.dart';
import 'widgets/campo_perfil.dart';
import 'widgets/opcion_perfil.dart';

class PerfilScreen extends StatefulWidget {
  final String nombre;
  final String email;
  final String rol;

  const PerfilScreen({
    super.key,
    required this.nombre,
    required this.email,
    required this.rol,
  });

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  bool _modoOscuro = false;

  @override
  void initState() {
    super.initState();
    // Los campos empiezan con los datos del usuario que inició sesión
    _usernameController.text = widget.email.split('@')[0];
    _nombreController.text = widget.nombre;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nombreController.dispose();
    super.dispose();
  }

  void _mostrarMensaje(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  void _cerrarSesion() async {
    bool si = await confirmar(context, '¿Deseas cerrar sesión?');
    if (si && mounted) {
      // Volvemos al login y borramos las pantallas anteriores
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (ruta) => false,
      );
    }
  }

  // Título pequeño de cada sección
  Widget _titulo(String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _modoOscuro ? AppColors.caramel : AppColors.gray700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Colores que cambian con el modo oscuro
    Color fondo = AppColors.gray200;
    Color colorTexto = AppColors.gray900;
    if (_modoOscuro) {
      fondo = const Color(0xFF1E1E1E);
      colorTexto = Colors.white;
    }

    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: AvatarPerfil(
              nombre: widget.nombre,
              rol: widget.rol,
              oscuro: _modoOscuro,
            ),
          ),

          // Datos personales
          _titulo('DATOS PERSONALES'),
          CampoPerfil(
            label: 'Nombre de usuario',
            controller: _usernameController,
            oscuro: _modoOscuro,
          ),
          const SizedBox(height: 8),
          CampoPerfil(
            label: 'Nombre completo',
            controller: _nombreController,
            oscuro: _modoOscuro,
          ),
          const SizedBox(height: 8),
          OpcionPerfil(
            icono: Icons.email_outlined,
            texto: widget.email,
            oscuro: _modoOscuro,
          ),
          OpcionPerfil(
            icono: Icons.store_outlined,
            texto: 'Sucursal Masatepe',
            oscuro: _modoOscuro,
          ),

          // Seguridad
          _titulo('SEGURIDAD'),
          OpcionPerfil(
            icono: Icons.lock_outline,
            texto: 'Cambiar contraseña',
            oscuro: _modoOscuro,
            onTap: () => _mostrarMensaje('Cambiar contraseña: próximamente'),
          ),

          // Apariencia
          _titulo('APARIENCIA'),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: Icon(
              _modoOscuro
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              color: colorTexto,
            ),
            title: Text('Modo oscuro', style: TextStyle(color: colorTexto)),
            activeTrackColor: AppColors.primary,
            value: _modoOscuro,
            onChanged: (valor) {
              setState(() {
                _modoOscuro = valor;
              });
            },
          ),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () => _mostrarMensaje('Cambios guardados con éxito'),
              child: const Text('Guardar cambios'),
            ),
          ),
          const SizedBox(height: 8),
          OpcionPerfil(
            icono: Icons.logout,
            texto: 'Cerrar sesión',
            esPeligro: true,
            oscuro: _modoOscuro,
            onTap: _cerrarSesion,
          ),
        ],
      ),
    );
  }
}
