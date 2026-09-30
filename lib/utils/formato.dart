// Convierte un número a texto en córdobas. Ejemplo: 85 -> C$ 85.00
String cordobas(double valor) {
  return 'C\$ ${valor.toStringAsFixed(2)}';
}
