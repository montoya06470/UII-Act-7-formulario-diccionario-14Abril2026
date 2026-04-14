import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inicio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.business_center,
                  size: 100,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Gestión de Empleados',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Sistema de registro y control',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/captura');
                  },
                  icon: const Icon(Icons.person_add, color: Colors.white, size: 28),
                  label: const Text(
                    'Capturar Empleados',
                    style: TextStyle(
                      fontSize: 20, 
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ver');
                  },
                  icon: const Icon(Icons.people_alt, color: Colors.white, size: 28),
                  label: const Text(
                    'Ver Empleados',
                    style: TextStyle(
                      fontSize: 20, 
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
