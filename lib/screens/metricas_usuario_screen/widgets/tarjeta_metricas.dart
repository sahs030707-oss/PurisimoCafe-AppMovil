// Responsable: MABELIN (sube 4ta)
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

// Tarjeta de un usuario. Al tocarla se muestran sus métricas
class TarjetaMetricas extends StatelessWidget {
  final String nombre;
  final String rol;
  final List<String> valores; // los 4 números que se muestran
  final bool abierta;
  final VoidCallback onTap;

  const TarjetaMetricas({
    super.key,
    required this.nombre,
    required this.rol,
    required this.valores,
    required this.abierta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // El administrador y el cajero tienen métricas distintas
    List<String> titulos = [
      'Clientes atendidos',
      'Total vendido',
      'Ventas realizadas',
      'Efectivo / Transf.',
    ];
    Color colorAvatar = AppColors.secondary;
    if (rol == 'Administrador') {
      titulos = [
        'Reportes generados',
        'Consultas inventario',
        'Productos modificados',
        'Ingresos gestionados',
      ];
      colorAvatar = AppColors.primary;
    }

    // Cuadritos con cada métrica
    List<Widget> cuadros = [];
    for (int i = 0; i < titulos.length; i++) {
      cuadros.add(Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titulos[i],
                style: const TextStyle(fontSize: 11, color: AppColors.gray700),
                textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(valores[i],
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary)),
          ],
        ),
      ));
    }

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: CircleAvatar(
              backgroundColor: colorAvatar,
              child:
                  Text(nombre[0], style: const TextStyle(color: Colors.white)),
            ),
            title: Text(nombre,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(rol),
            trailing: Icon(
                abierta ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
          ),
          if (abierta)
            Container(
              color: AppColors.gray200.withValues(alpha: 0.3),
              padding: const EdgeInsets.all(12),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: cuadros,
              ),
            ),
        ],
      ),
    );
  }
}
