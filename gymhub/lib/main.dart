import 'package:flutter/material.dart';
import 'package:gymhub/marco/inicio/inicio.dart';
import 'package:gymhub/marco/inicio/usuarios.dart';
// Importa otras páginas aquí

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/inicio',
      routes: {
        '/inicio': (context) => Inicio(),
        '/usuarios': (context) => Usuarios(),
        // Añade otras rutas aquí
      },
    );
  }
}