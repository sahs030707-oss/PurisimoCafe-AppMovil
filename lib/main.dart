import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'presentation/screens/login_screen/login_screen.dart';
import 'core/di/injection.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/producto_provider.dart';
import 'presentation/providers/usuario_provider.dart';
import 'presentation/providers/historial_provider.dart';
import 'presentation/providers/movimiento_provider.dart';

void main() {
  setupDependencies();
  runApp(const PurisimoCafeApp());
}

class PurisimoCafeApp extends StatelessWidget {
  const PurisimoCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<ProductoProvider>()),
        ChangeNotifierProvider(create: (context) => sl<UsuarioProvider>()),
        ChangeNotifierProvider(create: (context) => sl<HistorialProvider>()),
        ChangeNotifierProvider(create: (context) => sl<MovimientoProvider>()),
      ],
      child: MaterialApp(
        title: 'Purísimo Café',
        debugShowCheckedModeBanner: false,
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
        home: const LoginScreen(),
      ),
    );
  }
}
