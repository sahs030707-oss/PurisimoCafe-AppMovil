// Responsable: MABELIN (sube 4ta)
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'widgets/campo_preferencia.dart';

class PreferenciasUsuarioScreen extends StatefulWidget {
  const PreferenciasUsuarioScreen({super.key});

  @override
  State<PreferenciasUsuarioScreen> createState() =>
      _PreferenciasUsuarioScreenState();
}

class _PreferenciasUsuarioScreenState extends State<PreferenciasUsuarioScreen> {
  final TextEditingController _usernameController =
      TextEditingController(text: 'mabelinnn');
  final TextEditingController _nombreController =
      TextEditingController(text: 'Mabelin Zeledón');
  bool _modoOscuro = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _nombreController.dispose();
    super.dispose();
  }

  void _mostrarMensaje(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  // Título pequeño de cada sección
  Widget _titulo(String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
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
    Color fondo = Colors.white;
    Color colorTexto = Colors.black87;
    if (_modoOscuro) {
      fondo = const Color(0xFF1E1E1E);
      colorTexto = Colors.white;
    }

    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(title: const Text('Preferencias de usuario')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Perfil
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.caramel.withValues(alpha: 0.4),
                  child: const Icon(Icons.person_outline,
                      size: 36, color: AppColors.primary),
                ),
                const SizedBox(height: 6),
                Text(
                  'Mabelin Zeledón',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorTexto),
                ),
                const Text('Cajero', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          // Datos personales
          _titulo('DATOS PERSONALES'),
          CampoPreferencia(
              label: 'Nombre de usuario',
              controller: _usernameController,
              oscuro: _modoOscuro),
          const SizedBox(height: 8),
          CampoPreferencia(
              label: 'Nombre completo',
              controller: _nombreController,
              oscuro: _modoOscuro),

          // Seguridad
          _titulo('SEGURIDAD'),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.lock_outline, color: colorTexto),
            title:
                Text('Cambiar contraseña', style: TextStyle(color: colorTexto)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
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
                color: colorTexto),
            title: Text('Modo oscuro', style: TextStyle(color: colorTexto)),
            activeTrackColor: AppColors.primary,
            value: _modoOscuro,
            onChanged: (valor) {
              setState(() {
                _modoOscuro = valor;
              });
            },
          ),

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () => _mostrarMensaje('Cambios guardados con éxito'),
              child: const Text('Guardar cambios'),
            ),
          ),
        ],
      ),
    );
  }
}
