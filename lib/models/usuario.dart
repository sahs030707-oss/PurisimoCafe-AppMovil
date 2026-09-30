class Usuario {
  final String nombre;
  final String email;
  final String rol;
  bool activo; // no es final porque se puede activar/desactivar

  Usuario({
    required this.nombre,
    required this.email,
    required this.rol,
    this.activo = true,
  });
}
