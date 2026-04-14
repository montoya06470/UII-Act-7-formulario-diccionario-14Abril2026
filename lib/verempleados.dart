import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleadosScreen extends StatefulWidget {
  const VerEmpleadosScreen({Key? key}) : super(key: key);

  @override
  State<VerEmpleadosScreen> createState() => _VerEmpleadosScreenState();
}

class _VerEmpleadosScreenState extends State<VerEmpleadosScreen> {
  @override
  Widget build(BuildContext context) {
    // Convertimos los valores del diccionario en una lista para iterarlos
    final empleados = datosEmpleado.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empleados', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: empleados.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off, size: 100, color: Colors.black.withOpacity(0.3)),
                  const SizedBox(height: 20),
                  const Text(
                    'No hay empleados registrados',
                    style: TextStyle(
                      fontSize: 22, 
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ve a "Capturar Empleados" para agregar uno.',
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: empleados.length,
              itemBuilder: (context, index) {
                final empleado = empleados[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      leading: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            '#${empleado.id}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        empleado.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.work, size: 16, color: Colors.black54),
                                const SizedBox(width: 5),
                                Text(
                                  empleado.puesto,
                                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.attach_money, size: 16, color: Colors.green),
                                const SizedBox(width: 5),
                                Text(
                                  empleado.salario.toStringAsFixed(2),
                                  style: const TextStyle(
                                    color: Colors.green, 
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
