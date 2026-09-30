// Responsable: DANIELA (sube 2da)
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/datos_simulados.dart';
import '../../models/producto.dart';
import '../../utils/formato.dart';
import '../../widgets/selector_segmentos.dart';
import 'widgets/barra_grafica.dart';
import 'widgets/tarjeta_resumen.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});

  @override
  State<ReportesScreen> createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  int _periodo = 0; // 0 = semana, 1 = mes

  @override
  Widget build(BuildContext context) {
    // Sumamos todas las ventas y todas las compras
    double totalVentas = 0;
    for (var v in ventas) {
      totalVentas = totalVentas + v.total;
    }
    double totalCompras = 0;
    for (var c in compras) {
      totalCompras = totalCompras + c.total;
    }

    // Contamos los productos con poco stock
    int bajoStock = 0;
    for (Producto p in productos) {
      if (p.stock <= 5) {
        bajoStock = bajoStock + 1;
      }
    }

    // Datos de la gráfica según el periodo elegido
    Map<String, double> datos;
    if (_periodo == 0) {
      datos = ventasSemana;
    } else {
      datos = ventasMes;
    }

    // Buscamos el valor más grande para dibujar las barras
    double maximo = 0;
    List<Widget> barras = [];
    for (double valor in datos.values) {
      if (valor > maximo) {
        maximo = valor;
      }
    }
    for (String etiqueta in datos.keys) {
      barras.add(BarraGrafica(etiqueta: etiqueta, valor: datos[etiqueta]!, maximo: maximo));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: TarjetaResumen(
                  icono: Icons.point_of_sale,
                  titulo: 'Ventas',
                  valor: cordobas(totalVentas),
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TarjetaResumen(
                  icono: Icons.shopping_bag_outlined,
                  titulo: 'Compras',
                  valor: cordobas(totalCompras),
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TarjetaResumen(
                  icono: Icons.trending_up,
                  titulo: 'Ganancia',
                  valor: cordobas(totalVentas - totalCompras),
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TarjetaResumen(
                  icono: Icons.warning_amber_rounded,
                  titulo: 'Bajo stock',
                  valor: '$bajoStock productos',
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Ventas por periodo',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.gray900),
          ),
          const SizedBox(height: 12),
          SelectorSegmentos(
            opciones: const ['Semana', 'Mes'],
            seleccionado: _periodo,
            onChanged: (i) {
              setState(() {
                _periodo = i;
              });
            },
          ),
          const SizedBox(height: 16),
          Column(children: barras),
        ],
      ),
    );
  }
}
