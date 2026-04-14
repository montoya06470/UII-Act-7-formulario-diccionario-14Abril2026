import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  // Inicializamos un contador que será el ID autonumérico
  static int _siguienteId = 1;

  static void guardarEmpleado(String nombre, String puesto, double salario) {
    // 1. Crear el nuevo empleado
    Empleado nuevoEmpleado = Empleado(
      id: _siguienteId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );

    // 2. Guardarlo en el diccionario
    datosEmpleado[_siguienteId] = nuevoEmpleado;

    // 3. Incrementar el ID para el siguiente registro
    _siguienteId++;
  }
}
