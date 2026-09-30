class Producto {
  final String nombre;
  final String descripcion;
  final double precio;
  final String categoria;
  int stock; // no es final porque el inventario lo puede cambiar

  Producto({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.categoria,
    required this.stock,
  });

  bool get disponible => stock > 0;
  bool get bajoStock => stock > 0 && stock <= 5;
}
