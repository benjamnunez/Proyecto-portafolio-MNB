import 'package:flutter/material.dart';
import 'package:gymhub/marco/inicio/inicio.dart';
import 'package:gymhub/supabase_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          // TODO: Implementar la navegación al home
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: $error')),
        );
      }
    }
  }

  Future<void> _signUp() async {
    if (_signUpFormKey.currentState!.validate()) {
      try {
        final response = await SupabaseConfig.client.auth.signUp(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (response.user != null) {
          // Redireccionar al home si se crea la cuenta
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cuenta creada exitosamente')),
          );
          // TODO: Implementar la navegación al home
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear la cuenta: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar / Crear cuenta'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Entrar'),
            Tab(text: 'Crear cuenta'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLoginForm(),
          _buildSignUpForm(),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un correo electrónico';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
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
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _signUpFormKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un correo electrónico';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
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
              onPressed: _signUp,
              child: Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}