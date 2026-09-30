import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../models/producto.dart';
import '../../../utils/formato.dart';
import '../../../widgets/badge_estado.dart';
import '../../../widgets/tarjeta_item.dart';

// Tarjeta de un producto en el inventario, con botones de editar y eliminar
class ProductoInventarioCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const ProductoInventarioCard({
    super.key,
    required this.producto,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    // Color y texto según el stock que queda
    Color color = AppColors.success;
    String texto = 'Stock: ${producto.stock}';
    if (!producto.disponible) {
      color = AppColors.error;
      texto = 'Agotado';
    } else if (producto.bajoStock) {
      color = AppColors.warning;
      texto = 'Bajo: ${producto.stock}';
    }

    return TarjetaItem(
      icono: Icons.coffee_outlined,
      titulo: producto.nombre,
      subtitulo: '${cordobas(producto.precio)} · ${producto.categoria}',
      extra: BadgeEstado(texto: texto, color: color),
      derecha: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEditar,
            icon: const Icon(Icons.edit_outlined, color: AppColors.gray700),
          ),
          IconButton(
            onPressed: onEliminar,
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
          ),
        ],
      ),
    );
  }
}
