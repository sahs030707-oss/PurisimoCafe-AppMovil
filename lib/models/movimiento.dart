// Motivos posibles de una merma (producto perdido)
const List<String> motivosMerma = ['Dañado', 'Caducado', 'Perdido'];

class Movimiento {
  final String producto;
  final int cantidad;
  final String motivo;
  final String fecha;

  Movimiento({
    required this.producto,
    required this.cantidad,
    required this.motivo,
    required this.fecha,
  });
}
