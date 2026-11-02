import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/formato.dart';
import '../../../services/reporte_service.dart';
import '../../providers/historial_provider.dart';
import '../../providers/producto_provider.dart';
import '../../widgets/selector_segmentos.dart';
import 'widgets/barra_grafica.dart';
import 'widgets/tarjeta_resumen.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});

  @override
  State<ReportesScreen> createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  final ReporteService _service = sl<ReporteService>();
  int _periodo = 0; // 0 = semana, 1 = mes

  // Se ejecuta una vez, cuando se abre la pantalla
  @override
  void initState() {
    super.initState();
    final historial = context.read<HistorialProvider>();
    final productos = context.read<ProductoProvider>();
    Future.microtask(() {
      historial.cargar();
      productos.cargar();
    });
  }

  // Vuelve a pedir los datos a la API
  void _cargar() {
    context.read<HistorialProvider>().cargar();
    context.read<ProductoProvider>().cargar();
  }

  // Arma el reporte con los datos ya cargados
  Widget _reporte(HistorialProvider historial, ProductoProvider productos) {
    // Sumamos todas las ventas y todas las compras
    double totalVentas = _service.sumarTotal(historial.ventas);
    double totalCompras = _service.sumarTotal(historial.compras);

    // Contamos los productos con poco stock
    int bajoStock = _service.contarBajoStock(productos.productos);

    // Datos de la gráfica según el periodo elegido
    Map<String, double> datos;
    String tituloGrafica;
    if (_periodo == 0) {
      datos = _service.ventasDeLaSemana(historial.ventas);
      tituloGrafica = 'Ventas de esta semana';
    } else {
      datos = _service.ventasDelMes(historial.ventas);
      tituloGrafica = 'Ventas de este mes';
    }

    // Buscamos el valor más grande para dibujar las barras
    double maximo = 0;
    List<Widget> barras = [];
    for (double valor in datos.values) {
      if (valor > maximo) {
        maximo = valor;
      }
    }
    // Si no hubo ventas, evitamos dividir entre cero
    if (maximo == 0) {
      maximo = 1;
    }
    for (String etiqueta in datos.keys) {
      barras.add(BarraGrafica(
          etiqueta: etiqueta, valor: datos[etiqueta]!, maximo: maximo));
    }

    return ListView(
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
        Text(
          tituloGrafica,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTema.texto(context)),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final historial = context.watch<HistorialProvider>();
    final productos = context.watch<ProductoProvider>();

    // Decide qué mostrar: cargando, error o el reporte
    Widget cuerpo;
    if (historial.cargando || productos.cargando) {
      cuerpo = const Center(child: CircularProgressIndicator());
    } else if (historial.error != '' || productos.error != '') {
      String mensaje = historial.error;
      if (mensaje == '') {
        mensaje = productos.error;
      }
      cuerpo = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(mensaje, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _cargar,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    } else {
      cuerpo = _reporte(historial, productos);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      body: cuerpo,
    );
  }
}
