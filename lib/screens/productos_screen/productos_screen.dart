import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/producto.dart';
import 'widgets/product_card.dart';

/// Pantalla del catálogo de productos.
///
/// A propósito NO tiene datos simulados: [_productos] está vacía y
/// lista para llenarse cuando exista el backend (RF04/RF06/RF07 del
/// tablero). Mientras tanto, la pantalla muestra un estado vacío en
/// lugar de productos inventados.
class ProductosScreen extends StatelessWidget {
  const ProductosScreen({super.key});

  // TODO: reemplazar por la lista real obtenida del backend.
  static const List<Producto> _productos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: _productos.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_cafe_outlined,
                      size: 56,
                      color: AppColors.cafeGold,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Aún no hay productos cargados.\n'
                      'Aquí se mostrará el catálogo real una vez '
                      'conectado el backend.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: _productos.length,
              itemBuilder: (context, index) {
                final producto = _productos[index];
                return ProductCard(
                  product: producto,
                  onTap: () => _mostrarDetalle(context, producto),
                );
              },
            ),
    );
  }

  /// Muestra el detalle de un producto en un diálogo simple
  /// (nombre, precio, descripción, categoría y disponibilidad).
  void _mostrarDetalle(BuildContext context, Producto producto) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(producto.nombre),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categoría: ${producto.categoria}'),
            const SizedBox(height: 4),
            Text('Precio: C\$ ${producto.precio.toStringAsFixed(0)}'),
            const SizedBox(height: 4),
            Text(producto.disponible ? 'Disponible' : 'Agotado'),
            const SizedBox(height: 8),
            Text(producto.descripcion),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
