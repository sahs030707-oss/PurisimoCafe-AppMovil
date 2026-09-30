// Sirve para las ventas y las compras del historial
class Transaccion {
  final String codigo;
  final String detalle;
  final String fecha;
  final double total;

  Transaccion({
    required this.codigo,
    required this.detalle,
    required this.fecha,
    required this.total,
  });
}
