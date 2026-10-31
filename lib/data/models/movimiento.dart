import '../../core/utils/formato.dart';

// Motivos posibles de una merma (producto perdido)
const List<String> motivosMerma = ['Dañado', 'Caducado', 'Perdido'];

class Movimiento {
  final int productoId;
  final String producto;
  final int cantidad;
  final String motivo;
  final String fecha;

  Movimiento({
    this.productoId = 0,
    required this.producto,
    required this.cantidad,
    required this.motivo,
    required this.fecha,
  });

  // Convierte el JSON de la API en un Movimiento
  factory Movimiento.fromJson(Map<String, dynamic> json) {
    String fechaTextoFinal = '';
    if (json['fecha'] != null) {
      fechaTextoFinal = fechaTexto(DateTime.parse(json['fecha']));
    }

    return Movimiento(
      productoId: json['productoID'] ?? 0,
      producto: json['nombreProducto'] ?? '',
      cantidad: json['cantidad'] ?? 0,
      motivo: json['motivo'] ?? '',
      fecha: fechaTextoFinal,
    );
  }

  // Convierte el Movimiento en JSON para enviarlo a la API
  Map<String, dynamic> toJson() {
    return {
      'productoID': productoId,
      'cantidad': cantidad,
      'motivo': motivo,
    };
  }
}
