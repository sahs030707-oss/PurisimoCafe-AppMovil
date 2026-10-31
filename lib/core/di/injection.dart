import 'package:get_it/get_it.dart';
import '../../data/repositories/auth_repository.dart';
import '../../services/authentication_service.dart';
import '../network/api_client.dart';
import '../../data/repositories/productos_repository.dart';
import '../../presentation/providers/producto_provider.dart';
import '../../services/producto_service.dart';
import '../../data/repositories/usuarios_repository.dart';
import '../../presentation/providers/usuario_provider.dart';
import '../../services/usuario_service.dart';
import '../../data/repositories/compras_repository.dart';
import '../../data/repositories/ventas_repository.dart';
import '../../presentation/providers/historial_provider.dart';
import '../../services/historial_service.dart';
import '../../data/repositories/movimientos_repository.dart';
import '../../presentation/providers/movimiento_provider.dart';
import '../../services/movimiento_service.dart';
import '../../services/reporte_service.dart';

// Contenedor de dependencias
final sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService(sl(), sl()));
  sl.registerLazySingleton<ProductosRepository>(
      () => ProductosRepository(sl<ApiClient>()));
  sl.registerLazySingleton<ProductoService>(
      () => ProductoService(sl<ProductosRepository>()));
  sl.registerLazySingleton<ProductoProvider>(
      () => ProductoProvider(sl<ProductoService>()));
  sl.registerLazySingleton<UsuariosRepository>(
      () => UsuariosRepository(sl<ApiClient>()));
  sl.registerLazySingleton<UsuarioService>(() =>
      UsuarioService(sl<UsuariosRepository>(), sl<AuthenticationService>()));
  sl.registerLazySingleton<UsuarioProvider>(
      () => UsuarioProvider(sl<UsuarioService>()));
  sl.registerLazySingleton<VentasRepository>(
      () => VentasRepository(sl<ApiClient>()));
  sl.registerLazySingleton<ComprasRepository>(
      () => ComprasRepository(sl<ApiClient>()));
  sl.registerLazySingleton<HistorialService>(
      () => HistorialService(sl<VentasRepository>(), sl<ComprasRepository>()));
  sl.registerLazySingleton<HistorialProvider>(
      () => HistorialProvider(sl<HistorialService>()));
  sl.registerLazySingleton<MovimientosRepository>(
      () => MovimientosRepository(sl<ApiClient>()));
  sl.registerLazySingleton<MovimientoService>(
      () => MovimientoService(sl<MovimientosRepository>()));
  sl.registerLazySingleton<MovimientoProvider>(
      () => MovimientoProvider(sl<MovimientoService>()));
  sl.registerLazySingleton<ReporteService>(() => ReporteService());
}
