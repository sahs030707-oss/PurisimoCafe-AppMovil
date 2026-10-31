import '../../core/utils/formato.dart';

// Sirve para las ventas y las compras del historial
class Transaccion {
  final int id;
  final String codigo;
  final String detalle;
  final String fecha;
  final double total;
  final DateTime? fechaHora; // la fecha "real", sirve para los reportes
  final String usuario; // el cajero que hizo la venta o compra
  final double costo; // solo las ventas lo traen

  Transaccion({
    this.id = 0,
    required this.codigo,
    required this.detalle,
    required this.fecha,
    required this.total,
    this.fechaHora,
    this.usuario = '',
    this.costo = 0,
  });

  // Convierte el JSON de una VENTA en una Transaccion
  factory Transaccion.fromVentaJson(Map<String, dynamic> json) {
    int id = json['ventaID'] ?? 0;
    String cajero = json['cajero'] ?? '';
    DateTime fechaReal = DateTime.parse(json['fechaVenta']);

    return Transaccion(
      id: id,
      codigo: 'Venta #$id',
      detalle: 'Cajero: $cajero',
      fecha: fechaTexto(fechaReal),
      total: (json['total'] as num).toDouble(),
      fechaHora: fechaReal,
      usuario: cajero,
      costo: (json['costoTotal'] as num).toDouble(),
    );
  }

  // Convierte el JSON de una COMPRA en una Transaccion
  factory Transaccion.fromCompraJson(Map<String, dynamic> json) {
    int id = json['compraID'] ?? 0;
    String proveedor = json['nombreProveedor'] ?? '';
    String metodo = json['metodoPago'] ?? '';
    DateTime fechaReal = DateTime.parse(json['fechaCompra']);

    return Transaccion(
      id: id,
      codigo: 'Compra #$id',
      detalle: 'Proveedor: $proveedor · $metodo',
      fecha: fechaTexto(fechaReal),
      total: (json['total'] as num).toDouble(),
      fechaHora: fechaReal,
      usuario: json['nombreUsuario'] ?? '',
    );
  }
}
