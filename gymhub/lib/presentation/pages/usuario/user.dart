import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gymhub/services/supabase_user.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Usuarios")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _mostrarFormulario(context),
          child: Text("Crear Usuario"),
        ),
      ),
    );
  }

  void _mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final nombreController = TextEditingController();
        final apellidoController = TextEditingController();
        final emailController = TextEditingController();
        final rutController = TextEditingController();
        final dvController = TextEditingController();
        final fechaNacController = TextEditingController();
        final numeroController = TextEditingController();
        final direccionController = TextEditingController();

        return AlertDialog(
          title: Text("Nuevo Usuario"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nombreController, decoration: InputDecoration(labelText: "Nombre")),
              TextField(controller: apellidoController, decoration: InputDecoration(labelText: "Apellido")),
              TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
              TextField(controller: rutController, decoration: InputDecoration(labelText: "RUT")),
              TextField(controller: dvController, decoration: InputDecoration(labelText: "DV")),
              TextField(controller: fechaNacController, decoration: InputDecoration(labelText: "Fecha de Nacimiento")),
              TextField(controller: numeroController, decoration: InputDecoration(labelText: "Número")),
              TextField(controller: direccionController, decoration: InputDecoration(labelText: "Dirección")),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                SupabaseUser.agregarUsuario(
                  nombreController.text,
                  apellidoController.text,
                  rutController.text,
                  dvController.text,
                  fechaNacController.text,
                  emailController.text,
                  numeroController.text,
                  direccionController.text,
                );
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            ),
          ],
        );
      },
    );
  }
}
