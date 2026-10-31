import '../data/models/producto.dart';
import '../data/models/transaccion.dart';
import '../core/utils/formato.dart';
import '../data/models/usuario.dart';

class ReporteService {
  // Suma el total de una lista de ventas o de compras
  double sumarTotal(List<Transaccion> lista) {
    double suma = 0;
    for (Transaccion t in lista) {
      suma = suma + t.total;
    }
    return suma;
  }

  // Cuenta los productos con poco stock
  int contarBajoStock(List<Producto> productos) {
    int cantidad = 0;
    for (Producto p in productos) {
      if (p.stock <= 5) {
        cantidad = cantidad + 1;
      }
    }
    return cantidad;
  }

  // Ventas de la semana actual: un total por cada día
  Map<String, double> ventasDeLaSemana(List<Transaccion> ventas) {
    List<String> dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

    // Empezamos con todos los días en 0
    Map<String, double> resultado = {};
    for (String dia in dias) {
      resultado[dia] = 0;
    }

    // Calculamos el lunes de esta semana y el lunes de la siguiente
    DateTime hoy = DateTime.now();
    DateTime lunes = DateTime(hoy.year, hoy.month, hoy.day)
        .subtract(Duration(days: hoy.weekday - 1));
    DateTime siguienteLunes = lunes.add(const Duration(days: 7));

    for (Transaccion v in ventas) {
      DateTime? fecha = v.fechaHora;
      if (fecha == null) continue;

      bool esDeEstaSemana =
          !fecha.isBefore(lunes) && fecha.isBefore(siguienteLunes);
      if (esDeEstaSemana) {
        String dia = dias[fecha.weekday - 1];
        resultado[dia] = resultado[dia]! + v.total;
      }
    }
    return resultado;
  }

  // Ventas del mes actual: un total por cada semana
  Map<String, double> ventasDelMes(List<Transaccion> ventas) {
    Map<String, double> resultado = {
      'Sem 1': 0,
      'Sem 2': 0,
      'Sem 3': 0,
      'Sem 4': 0,
    };
    List<String> semanas = ['Sem 1', 'Sem 2', 'Sem 3', 'Sem 4'];

    DateTime hoy = DateTime.now();

    for (Transaccion v in ventas) {
      DateTime? fecha = v.fechaHora;
      if (fecha == null) continue;

      bool esDeEsteMes = fecha.year == hoy.year && fecha.month == hoy.month;
      if (esDeEsteMes) {
        int numero = (fecha.day - 1) ~/ 7;
        if (numero > 3) {
          numero = 3;
        }
        String semana = semanas[numero];
        resultado[semana] = resultado[semana]! + v.total;
      }
    }
    return resultado;
  }

  // Calcula las 4 métricas de un usuario.
  // Los cajeros se miden con sus ventas y los administradores con sus compras.
  List<String> metricasDeUsuario(
      Usuario usuario, List<Transaccion> ventas, List<Transaccion> compras) {
    List<Transaccion> lista;
    if (usuario.rol == 'Administrador') {
      lista = compras;
    } else {
      lista = ventas;
    }

    int cantidad = 0;
    double total = 0;
    DateTime? ultima;

    for (Transaccion t in lista) {
      // Solo contamos lo que hizo este usuario
      if (t.usuario == usuario.nombre) {
        cantidad = cantidad + 1;
        total = total + t.total;

        DateTime? fecha = t.fechaHora;
        if (fecha != null && (ultima == null || fecha.isAfter(ultima))) {
          ultima = fecha;
        }
      }
    }

    double promedio = 0;
    if (cantidad > 0) {
      promedio = total / cantidad;
    }

    String textoUltima = 'Sin registros';
    if (ultima != null) {
      textoUltima = fechaCorta(ultima);
    }

    return ['$cantidad', cordobas(total), cordobas(promedio), textoUltima];
  }
}
