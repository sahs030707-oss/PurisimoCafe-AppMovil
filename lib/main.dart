import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'screens/welcome_screen/welcome_screen.dart';

void main() {
  runApp(const PurisimoCafeApp());
}

class PurisimoCafeApp extends StatelessWidget {
  const PurisimoCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Purísimo Café',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.cafePale,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.cafeGold,
          primary: AppColors.cafeGold,
          secondary: AppColors.cafeBrown,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.cafeBrown,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
