import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../login_screen/login_screen.dart';
import '../productos_screen/productos_screen.dart';

/// Pantalla mostrada después de iniciar sesión.
///
/// Recibe el nombre y el rol del usuario directamente como
/// parámetros del constructor (sin librerías de manejo de estado,
/// para mantener el proyecto simple). El menú de opciones cambia
/// según el rol, cumpliendo la restricción de permisos por usuario.
class HomeScreen extends StatelessWidget {
  final String nombreUsuario;
  final String rol;

  const HomeScreen({
    super.key,
    required this.nombreUsuario,
    required this.rol,
  });

  List<(IconData, String)> get _opciones {
    final comunes = <(IconData, String)>[
      (Icons.coffee_rounded, 'Catálogo'),
    ];

    if (rol == 'Administrador') {
      return [
        ...comunes,
        (Icons.inventory_2_outlined, 'Inventario'),
        (Icons.people_outline, 'Usuarios'),
        (Icons.bar_chart_rounded, 'Reportes'),
      ];
    }

    // Cajero: opciones más acotadas.
    return [
      ...comunes,
      (Icons.point_of_sale_outlined, 'Ventas'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purísimo Café'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.cafeGold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                rol,
                style: const TextStyle(
                  color: AppColors.cafeBrown,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text('Opciones disponibles',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: _opciones.map((op) {
                  final icon = op.$1;
                  final label = op.$2;
                  return _OpcionCard(
                    icon: icon,
                    label: label,
                    onTap: label == 'Catálogo'
                        ? () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ProductosScreen(),
                              ),
                            )
                        : null,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta de opción del menú. Es privada porque solo la usa esta
/// pantalla; si otra pantalla llegara a necesitarla, se movería a
/// `lib/widgets/` como widget compartido.
class _OpcionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _OpcionCard({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap ??
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$label: próximamente')),
              );
            },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: AppColors.cafeBrown),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
