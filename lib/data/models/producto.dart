class Producto {
  final int id;
  final String nombre;
  String descripcion; // no es final porque se llena después
  final double precio;
  final String categoria;
  int stock; // no es final porque el inventario lo puede cambiar
  final bool estado;

  Producto({
    this.id = 0,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.categoria,
    required this.stock,
    this.estado = true,
  });

  bool get disponible => stock > 0;
  bool get bajoStock => stock > 0 && stock <= 5;

  // Convierte el JSON que manda la API (Inventario) en un Producto
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['productoID'] ?? 0,
      nombre: json['nombreProducto'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precio: (json['precioUnitario'] as num).toDouble(),
      categoria: json['categoria'] ?? '',
      stock: json['stockActual'] ?? 0,
      estado: json['estado'] ?? true,
    );
  }
}
