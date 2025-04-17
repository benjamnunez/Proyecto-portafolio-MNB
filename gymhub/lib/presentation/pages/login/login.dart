import 'package:flutter/material.dart';
import 'package:gymhub/presentation/pages/home/inicio.dart';
import 'package:gymhub/services/supabase_config.dart';

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
        backgroundColor: Color(0xFF1A1F23),
        body: 
          Center(
                child: 
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                        color: Color(0xFF1A1F23),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(100, 205, 205, 205),
                        ),
                  ),
                    child: 
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo/logoTransparenteGymHubBlanco.png'
                          ,
                            width: 200, // ajusta según tus necesidades
                            height: 200, // ajusta según tus necesidades
                          ),
                        TabBar(
                              controller: _tabController,
                              tabs: [
                                Tab(text: 'Entrar', ),
                                Tab(text: 'Crear cuenta'),
                              ],
                              labelColor: Colors.white,
                              indicatorColor: Colors.white,
                            ),
                        SizedBox(
                          height: 200,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildLoginForm(),
                              _buildSignUpForm(),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.white),),
                            SizedBox(width: 8),
                            Text("> Haz clic aquí <",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
              ),
      );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.white)),
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
              decoration: InputDecoration(labelText: 'Contraseña',labelStyle: TextStyle(color: Colors.white)),
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
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Email',labelStyle: TextStyle(color: Colors.white)),
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
              decoration: InputDecoration(labelText: 'Contraseña',labelStyle: TextStyle(color: Colors.white)),
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