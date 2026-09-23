/// Representa un producto del catálogo.
///
/// Por ahora no hay datos: esta clase está lista para llenarse desde
/// el backend cuando se conecte (nombre, precio, descripción,
/// categoría y disponibilidad, tal como pide RF05 en el tablero).
class Producto {
  final String nombre;
  final String descripcion;
  final double precio;
  final String categoria;
  final bool disponible;

  const Producto({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.categoria,
    this.disponible = true,
  });
}
