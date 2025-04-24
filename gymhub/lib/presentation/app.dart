import 'package:flutter/material.dart';
import 'package:gymhub/presentation/pages/home/inicio.dart';
import 'package:gymhub/presentation/pages/usuario/user.dart';
import 'package:gymhub/presentation/pages/ajustes/ajustes.dart';
import 'package:gymhub/services/supabase_config.dart';
import 'package:gymhub/presentation/pages/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializamos Supabase antes de arrancar la app
  await SupabaseConfig.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SessionGate(),
        '/login': (_) => LoginPage(),
        '/inicio': (_) =>  Inicio(),
        '/usuarios': (_) =>  UserScreen(),
        '/ajustes': (_) =>  Ajustes(),
      },
    );
  }
}

class SessionGate extends StatelessWidget {
  const SessionGate({super.key});

  @override
  Widget build(BuildContext context) {
    final session = SupabaseConfig.client.auth.currentSession;

    if (session != null) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/inicio');
      });
    } else {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
