import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_colors.dart';
import 'core/di/injection.dart';
import 'presentation/providers/historial_provider.dart';
import 'presentation/providers/movimiento_provider.dart';
import 'presentation/providers/producto_provider.dart';
import 'presentation/providers/tema_provider.dart';
import 'presentation/providers/usuario_provider.dart';
import 'presentation/screens/login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  // Leemos el modo guardado antes de mostrar la app
  await sl<TemaProvider>().cargar();
  runApp(const PurisimoCafeApp());
}

class PurisimoCafeApp extends StatelessWidget {
  const PurisimoCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<TemaProvider>()),
        ChangeNotifierProvider(create: (context) => sl<ProductoProvider>()),
        ChangeNotifierProvider(create: (context) => sl<UsuarioProvider>()),
        ChangeNotifierProvider(create: (context) => sl<HistorialProvider>()),
        ChangeNotifierProvider(create: (context) => sl<MovimientoProvider>()),
      ],
      child: Consumer<TemaProvider>(
        builder: (context, tema, child) {
          // Elegimos el modo según la preferencia guardada
          ThemeMode modo = ThemeMode.light;
          if (tema.modoOscuro) {
            modo = ThemeMode.dark;
          }

          return MaterialApp(
            title: 'Purísimo Café',
            debugShowCheckedModeBanner: false,
            themeMode: modo,
            // Tema claro
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.gray200,
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                centerTitle: true,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            // Tema oscuro
            darkTheme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.fondoOscuro,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                brightness: Brightness.dark,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                centerTitle: true,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
