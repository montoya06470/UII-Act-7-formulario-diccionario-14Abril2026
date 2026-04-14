import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleadosScreen extends StatefulWidget {
  const CapturaEmpleadosScreen({Key? key}) : super(key: key);

  @override
  _CapturaEmpleadosScreenState createState() => _CapturaEmpleadosScreenState();
}

class _CapturaEmpleadosScreenState extends State<CapturaEmpleadosScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      final double? salario = double.tryParse(_salarioController.text);
      if (salario == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, ingresa un salario válido.', style: TextStyle(color: Colors.white))),
        );
        return;
      }

      // Llamada al agente para guardar los datos
      GuardarDatosDiccionario.guardarEmpleado(
        _nombreController.text.trim(),
        _puestoController.text.trim(),
        salario,
      );

      // Feedback visual
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('¡Empleado guardado exitosamente!', style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      // Limpiar campos
      _nombreController.clear();
      _puestoController.clear();
      _salarioController.clear();
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _puestoController.dispose();
    _salarioController.dispose();
    super.dispose();
  }

  InputDecoration _construirInputDecoration(String label, IconData icono) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
      prefixIcon: Icon(icono, color: Colors.red),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar Empleados', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.person_add_alt_1, size: 80, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  'Ingresa los datos del nuevo empleado',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        decoration: _construirInputDecoration('Nombre', Icons.person),
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingresa el nombre';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _puestoController,
                        decoration: _construirInputDecoration('Puesto', Icons.work),
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingresa el puesto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _salarioController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        decoration: _construirInputDecoration('Salario (\$)', Icons.attach_money),
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _guardar(),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingresa el salario';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton.icon(
                          onPressed: _guardar,
                          icon: const Icon(Icons.save, color: Colors.white, size: 28),
                          label: const Text(
                            'Guardar Registro',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
