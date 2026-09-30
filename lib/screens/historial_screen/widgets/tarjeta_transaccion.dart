import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../models/transaccion.dart';
import '../../../utils/formato.dart';
import '../../../widgets/tarjeta_item.dart';

// Tarjeta de una venta o de una compra
class TarjetaTransaccion extends StatelessWidget {
  final Transaccion transaccion;
  final bool esVenta;

  const TarjetaTransaccion(
      {super.key, required this.transaccion, required this.esVenta});

  @override
  Widget build(BuildContext context) {
    return TarjetaItem(
      icono: esVenta ? Icons.receipt_long : Icons.shopping_bag_outlined,
      colorIcono: esVenta ? AppColors.success : AppColors.primary,
      titulo: transaccion.codigo,
      subtitulo: '${transaccion.detalle}\n${transaccion.fecha}',
      derecha: Text(
        cordobas(transaccion.total),
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.gray900),
      ),
    );
  }
}
