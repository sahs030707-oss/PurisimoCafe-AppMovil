import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/formato.dart';

// Una barra horizontal de la gráfica de ventas
class BarraGrafica extends StatelessWidget {
  final String etiqueta;
  final double valor;
  final double maximo; // la barra más grande, sirve para calcular el tamaño

  const BarraGrafica({
    super.key,
    required this.etiqueta,
    required this.valor,
    required this.maximo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(width: 48, child: Text(etiqueta)),
          Expanded(
            child: LinearProgressIndicator(
              value: valor / maximo,
              minHeight: 14,
              color: AppColors.primary,
              backgroundColor: AppColors.gray200,
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              cordobas(valor),
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.gray900),
            ),
          ),
        ],
      ),
    );
  }
}
