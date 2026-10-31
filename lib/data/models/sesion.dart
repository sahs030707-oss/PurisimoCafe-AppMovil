class Sesion {
  final String token;
  final int usuarioId;
  final String nombre;
  final String correo;
  final int rolId;

  Sesion({
    required this.token,
    required this.usuarioId,
    required this.nombre,
    required this.correo,
    required this.rolId,
  });

  // Convierte el rolId (número) en texto
  String get rol {
    if (rolId == 1) {
      return 'Administrador';
    }
    return 'Cajero';
  }

  // Convierte el JSON del login en una Sesion
  factory Sesion.fromJson(Map<String, dynamic> json) {
    return Sesion(
      token: json['token'] ?? '',
      usuarioId: json['usuarioId'] ?? 0,
      nombre: json['usuario'] ?? '',
      correo: json['correo'] ?? '',
      rolId: json['rolId'] ?? 2,
    );
  }
}
