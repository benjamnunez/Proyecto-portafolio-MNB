import 'package:flutter/material.dart';
import 'package:gymhub/presentation/pages/home/inicio.dart';
import 'package:gymhub/services/supabase_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_loginFormKey.currentState!.validate()) {
      try {
        final response = await SupabaseConfig.client.auth.signInWithPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (response.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Inicio()),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Inicio de sesión exitoso')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1F23),
      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF1A1F23),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: const Color.fromARGB(100, 205, 205, 205),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo/logoTransparenteGymHubBlanco.png',
                width: 200,
                height: 200,
              ),
              _buildLoginForm(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 8),
                  Text("> Haz clic aquí <", style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _emailController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un correo electrónico';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: TextStyle(color: Colors.white),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una contraseña';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _signIn,
            child: Text('Entrar'),
          ),
        ],
      ),
    );
  }
}
