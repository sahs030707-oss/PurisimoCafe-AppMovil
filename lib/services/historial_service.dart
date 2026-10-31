import '../data/models/transaccion.dart';
import '../data/repositories/compras_repository.dart';
import '../data/repositories/ventas_repository.dart';

class HistorialService {
  final VentasRepository _ventasRepository;
  final ComprasRepository _comprasRepository;

  HistorialService(this._ventasRepository, this._comprasRepository);

  // Devuelve las ventas, de la más reciente a la más antigua
  Future<List<Transaccion>> obtenerVentas() async {
    List<Transaccion> lista = await _ventasRepository.listarAsync();
    _ordenar(lista);
    return lista;
  }

  // Devuelve las compras, de la más reciente a la más antigua
  Future<List<Transaccion>> obtenerCompras() async {
    List<Transaccion> lista = await _comprasRepository.listarAsync();
    _ordenar(lista);
    return lista;
  }

  // Ordena la lista poniendo primero lo más reciente
  void _ordenar(List<Transaccion> lista) {
    lista.sort((a, b) {
      DateTime fechaA = a.fechaHora ?? DateTime(2000);
      DateTime fechaB = b.fechaHora ?? DateTime(2000);
      return fechaB.compareTo(fechaA);
    });
  }
}
