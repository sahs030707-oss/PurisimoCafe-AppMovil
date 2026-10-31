// Convierte un número a texto en córdobas. Ejemplo: 85 -> C$ 85.00
String cordobas(double valor) {
  return 'C\$ ${valor.toStringAsFixed(2)}';
}

// Convierte una fecha a texto. Ejemplo: 25/09/2026 - 10:35 AM
String fechaTexto(DateTime fecha) {
  String dia = fecha.day.toString().padLeft(2, '0');
  String mes = fecha.month.toString().padLeft(2, '0');
  String minuto = fecha.minute.toString().padLeft(2, '0');

  int hora = fecha.hour % 12;
  if (hora == 0) {
    hora = 12;
  }
  String ampm = fecha.hour >= 12 ? 'PM' : 'AM';

  return '$dia/$mes/${fecha.year} - $hora:$minuto $ampm';
}

// Convierte una fecha a texto corto. Ejemplo: 25/09/2026
String fechaCorta(DateTime fecha) {
  String dia = fecha.day.toString().padLeft(2, '0');
  String mes = fecha.month.toString().padLeft(2, '0');
  return '$dia/$mes/${fecha.year}';
}
