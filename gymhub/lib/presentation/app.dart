import 'package:flutter/material.dart';
import 'package:gymhub/presentation/pages/home/home.dart';
import 'package:gymhub/presentation/pages/usuario/user.dart';
import 'package:gymhub/presentation/pages/planes/planes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/inicio',
      routes: {
        '/inicio': (_) =>  Inicio(),
        '/usuarios':(_) => UserApp(),
        '/planes':(_) => Planes(),
        
      },
    );
  }
}