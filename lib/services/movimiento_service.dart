import '../core/errors/app_exception.dart';
import '../data/models/movimiento.dart';
import '../data/repositories/movimientos_repository.dart';

class MovimientoService {
  final MovimientosRepository _repository;

  MovimientoService(this._repository);

  Future<List<Movimiento>> obtenerMovimientos() async {
    return await _repository.listarAsync();
  }

  // Registra una merma después de revisar las reglas
  Future<void> registrarMerma(Movimiento movimiento) async {
    if (movimiento.productoId <= 0) {
      throw AppException('Selecciona un producto.');
    }
    if (movimiento.cantidad <= 0) {
      throw AppException('La cantidad debe ser mayor a 0.');
    }
    if (!motivosMerma.contains(movimiento.motivo)) {
      throw AppException('El motivo no es válido.');
    }

    await _repository.registrarAsync(movimiento);
  }
}
