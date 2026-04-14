import 'dart:io';

void printPaso(String texto) {
  print('\n\x1B[36m>> $texto\x1B[0m'); // Texto en cian
}

void printExito(String texto) {
  print('\x1B[32m✔ $texto\x1B[0m'); // Texto en verde
}

void printError(String texto) {
  print('\n\x1B[31mError: $texto\x1B[0m'); // Texto en rojo
}

Future<void> main() async {
  print('=============================================');
  print('🚀 Agente de Repositorio GitHub interactivo 🚀');
  print('=============================================');

  // 1. Verificar si git está inicializado
  var statusResult = await Process.run('git', ['status']);
  if (statusResult.exitCode != 0) {
    printPaso('Inicializando repositorio Git...');
    await Process.run('git', ['init']);
    printExito('Repositorio inicializado (git init).');
  } else {
    printExito('El repositorio ya está inicializado.');
  }

  // 2. Establecer la rama por defecto a "main"
  await Process.run('git', ['branch', '-M', 'main']);
  printExito('Rama principal establecida como "main".');

  // 3. Verificar y preguntar por el link del remoto (origin)
  var remoteResult = await Process.run('git', ['remote', '-v']);
  String remotes = remoteResult.stdout.toString();
  
  if (remotes.isEmpty) {
    printPaso('No se ha detectado el link del repositorio remoto en GitHub.');
    stdout.write('Introduce el link (URL) de tu repositorio de GitHub: ');
    String? url = stdin.readLineSync();
    
    if (url != null && url.trim().isNotEmpty) {
      await Process.run('git', ['remote', 'add', 'origin', url.trim()]);
      printExito('Remoto añadido: ${url.trim()}');
    } else {
      printError('No se proporcionó una URL. Se cancelará el proceso.');
      return;
    }
  } else {
    printExito('El repositorio remoto ya está configurado.');
    print(remotes.trim());
  }

  // 4. Agregar los cambios (git add .)
  printPaso('Añadiendo todos los archivos a stage (git add .)...');
  await Process.run('git', ['add', '.']);
  printExito('Archivos añadidos.');

  // 5. Preguntar por el mensaje de commit
  stdout.write('\nIntroduce el mensaje para el commit (ej. "Versión inicial"): ');
  String? commitMsg = stdin.readLineSync();
  
  if (commitMsg == null || commitMsg.trim().isEmpty) {
    commitMsg = 'Actualización automática'; // Mensaje por defecto
    print('Se utilizará el mensaje por defecto: "$commitMsg"');
  }
  
  var commitResult = await Process.run('git', ['commit', '-m', commitMsg]);
  if (commitResult.exitCode != 0) {
    if (commitResult.stdout.toString().contains('nothing to commit') || 
        commitResult.stderr.toString().contains('nothing to commit')) {
      printExito('No hay cambios nuevos para realizar el commit.');
    } else {
      printError('Falló el commit:\n${commitResult.stderr}\n${commitResult.stdout}');
      return;
    }
  } else {
    printExito('Commit realizado exitosamente: "$commitMsg"');
  }

  // 6. Preguntar a qué rama se va a enviar (push)
  printPaso('Comenzando el envío de archivos (push).');
  stdout.write('¿A qué rama deseas enviarlos? (Presiona Enter para "main"): ');
  String? branch = stdin.readLineSync();
  
  if (branch == null || branch.trim().isEmpty) {
    branch = 'main';
  } else {
    branch = branch.trim();
  }

  // 7. Ejecutar el Push
  printPaso('Enviando cambios a origin/$branch...');
  
  // Usamos Process.start para visualizar la barra de progreso natural de git
  var pushProcess = await Process.start('git', ['push', '-u', 'origin', branch]);
  
  await stdout.addStream(pushProcess.stdout);
  await stderr.addStream(pushProcess.stderr);
  
  var pushExitCode = await pushProcess.exitCode;

  if (pushExitCode == 0) {
    print('\n=============================================');
    print('\x1B[32m🎉 ¡Proceso finalizado! Cambios subidos a GitHub en la rama "$branch" 🎉\x1B[0m');
    print('=============================================');
  } else {
    printError('Hubo un problema al subir los cambios a GitHub. Revisa el registro arriba.');
  }
}
