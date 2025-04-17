import 'package:flutter/material.dart';
import 'package:gymhub/presentation/pages/home/inicio.dart';
import 'package:gymhub/presentation/pages/usuario/user.dart';
import 'package:gymhub/presentation/pages/ajustes/ajustes.dart';
import 'package:gymhub/services/supabase_config.dart';
import 'package:gymhub/presentation/pages/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SupabaseConfig.initialize();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymHub',
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginPage(),
        '/inicio': (_) => Inicio(),
        '/usuarios': (_) => UserApp(),
        '/ajustes': (_) => Ajustes(),
      },
    );
  }
}
