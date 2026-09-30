import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/badge_estado.dart';
import '../historial_screen/historial_screen.dart';
import '../inventario_screen/inventario_screen.dart';
import '../login_screen/login_screen.dart';
import '../metricas_usuario_screen/metricas_usuario_screen.dart';
import '../movimiento_inventario_screen/movimiento_inventario_screen.dart';
import '../perfil_screen/perfil_screen.dart';
import '../preferencias_usuario_screen/preferencias_usuario_screen.dart';
import '../productos_screen/productos_screen.dart';
import '../reportes_screen/reportes_screen.dart';
import '../usuarios_screen/usuarios_screen.dart';

class HomeScreen extends StatelessWidget {
  final String nombreUsuario;
  final String email;
  final String rol;

  const HomeScreen({
    super.key,
    required this.nombreUsuario,
    required this.email,
    required this.rol,
  });

  // Abre otra pantalla
  void _ir(BuildContext context, Widget pantalla) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pantalla));
  }

  // Botones que ve el Administrador
  List<Widget> _botonesAdmin(BuildContext context) {
    return [
      _OpcionCard(
          icon: Icons.coffee_rounded,
          label: 'Catálogo',
          onTap: () => _ir(context, const ProductosScreen())),
      _OpcionCard(
          icon: Icons.receipt_long,
          label: 'Historial',
          onTap: () => _ir(context, const HistorialScreen())),
      _OpcionCard(
          icon: Icons.inventory_2_outlined,
          label: 'Inventario',
          onTap: () => _ir(context, const InventarioScreen())),
      _OpcionCard(
          icon: Icons.delete_sweep_outlined,
          label: 'Mermas',
          onTap: () => _ir(context, const MovimientoInventarioScreen())),
      _OpcionCard(
          icon: Icons.people_outline,
          label: 'Usuarios',
          onTap: () => _ir(context, const UsuariosScreen())),
      _OpcionCard(
          icon: Icons.bar_chart_rounded,
          label: 'Reportes',
          onTap: () => _ir(context, const ReportesScreen())),
      _OpcionCard(
          icon: Icons.query_stats_rounded,
          label: 'Métricas de usuario',
          onTap: () => _ir(context, const MetricasUsuarioScreen())),
      _OpcionCard(
          icon: Icons.tune_rounded,
          label: 'Preferencias',
          onTap: () => _ir(context, const PreferenciasUsuarioScreen())),
      _OpcionCard(
          icon: Icons.person_outline,
          label: 'Mi perfil',
          onTap: () => _ir(context,
              PerfilScreen(nombre: nombreUsuario, email: email, rol: rol))),
    ];
  }

  // Botones que ve el Cajero
  List<Widget> _botonesCajero(BuildContext context) {
    return [
      _OpcionCard(
          icon: Icons.coffee_rounded,
          label: 'Catálogo',
          onTap: () => _ir(context, const ProductosScreen())),
      _OpcionCard(
          icon: Icons.receipt_long,
          label: 'Historial',
          onTap: () => _ir(context, const HistorialScreen())),
      _OpcionCard(
          icon: Icons.inventory_2_outlined,
          label: 'Inventario',
          onTap: () => _ir(context, const InventarioScreen())),
      _OpcionCard(
          icon: Icons.person_outline,
          label: 'Mi perfil',
          onTap: () => _ir(context,
              PerfilScreen(nombre: nombreUsuario, email: email, rol: rol))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Según el rol mostramos unos botones u otros
    List<Widget> botones;
    if (rol == 'Administrador') {
      botones = _botonesAdmin(context);
    } else {
      botones = _botonesCajero(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purísimo Café'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hola, $nombreUsuario',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 4),
            BadgeEstado(texto: rol, color: AppColors.secondary),
            const SizedBox(height: 32),
            Text('Opciones disponibles',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: botones,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Cuadro con icono y nombre para cada opción del menú
class _OpcionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _OpcionCard(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: AppColors.gray900)),
          ],
        ),
      ),
    );
  }
}
