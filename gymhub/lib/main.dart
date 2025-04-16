import 'package:flutter/material.dart';
import 'package:gymhub/marco/inicio/inicio.dart';
import 'package:gymhub/supabase_config.dart';
import 'package:gymhub/marco/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SupabaseConfig.initialize();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymHub',
      home: LoginPage(),
      routes: {
        '/inicio': (_) =>  Inicio(),        
      },
    );
  }
}