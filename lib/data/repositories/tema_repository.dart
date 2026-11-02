import 'package:shared_preferences/shared_preferences.dart';

class TemaRepository {
  // Nombre con el que se guarda el dato en el celular
  static const String _clave = 'modo_oscuro';

  // Lee si el modo oscuro estaba activado
  Future<bool> leerModoOscuro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_clave) ?? false;
  }

  // Guarda si el modo oscuro está activado o no
  Future<void> guardarModoOscuro(bool valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_clave, valor);
  }
}
