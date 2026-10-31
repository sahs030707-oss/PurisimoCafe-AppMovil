class Usuario {
  final int id;
  final String nombre;
  final String email;
  final String rol;
  bool activo; // no es final porque se puede activar/desactivar

  Usuario({
    this.id = 0,
    required this.nombre,
    required this.email,
    required this.rol,
    this.activo = true,
  });

  // Convierte el JSON de la API en un Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    int rolId = json['rolID'] ?? 2;

    String nombreRol;
    if (rolId == 1) {
      nombreRol = 'Administrador';
    } else {
      nombreRol = 'Cajero';
    }

    return Usuario(
      id: json['usuarioID'] ?? 0,
      nombre: json['nombre'] ?? '',
      email: json['correo'] ?? '',
      rol: nombreRol,
      activo: json['estado'] ?? true,
    );
  }

  // Convierte el Usuario en JSON para enviarlo a la API
  Map<String, dynamic> toJson() {
    return {
      'usuarioID': id,
      'nombre': nombre,
      'correo': email,
      'estado': activo,
      'rolID': rol == 'Administrador' ? 1 : 2,
    };
  }
}
