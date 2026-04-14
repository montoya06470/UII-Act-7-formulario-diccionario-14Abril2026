import 'package:flutter/material.dart';
import 'inicio.dart';
import 'capturaempleados.dart';
import 'verempleados.dart';

void main() {
  runApp(const EmpleadosApp());
}

class EmpleadosApp extends StatelessWidget {
  const EmpleadosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definimos los colores principales según las instrucciones
    // Color principal: Rojo brillante
    const Color colorRojo = Colors.red;
    // Color secundario: Rosa claro
    const Color rosaClaro = Color(0xFFFFB6C1); 
    
    return MaterialApp(
      title: 'Registro de Empleados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: rosaClaro,
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorRojo,
          primary: colorRojo,
          secondary: rosaClaro,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: colorRojo,
          foregroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        // Tipografía por defecto
        fontFamily: 'Roboto', 
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InicioScreen(),
        '/captura': (context) => const CapturaEmpleadosScreen(),
        '/ver': (context) => const VerEmpleadosScreen(),
      },
    );
  }
}
