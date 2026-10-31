import 'package:flutter/material.dart';
import '../../core/errors/app_exception.dart';
import '../../data/models/movimiento.dart';
import '../../services/movimiento_service.dart';

class MovimientoProvider extends ChangeNotifier {
  final MovimientoService service;

  MovimientoProvider(this.service);

  List<Movimiento> movimientos = [];
  bool cargando = false;
  String error = '';

  // Pide las mermas a la API
  Future<void> cargar() async {
    cargando = true;
    error = '';
    notifyListeners();

    try {
      movimientos = await service.obtenerMovimientos();
    } on AppException catch (e) {
      error = e.mensaje;
    } catch (e) {
      error = 'Ocurrió un error inesperado';
    }

    cargando = false;
    notifyListeners();
  }

  // Registra una merma y actualiza la lista.
  // Devuelve '' si todo salió bien, o el mensaje del error.
  Future<String> registrar(Movimiento movimiento) async {
    try {
      await service.registrarMerma(movimiento);
      movimientos = await service.obtenerMovimientos();
      notifyListeners();
      return '';
    } on AppException catch (e) {
      return e.mensaje;
    } catch (e) {
      return 'Ocurrió un error inesperado';
    }
  }
}
