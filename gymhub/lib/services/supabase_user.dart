import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';
import 'registro_auth.dart';

class SupabaseUser {
  static Future<void> agregarUsuario(
    String nombre,
    String apellido,
    String rut,
    String dv,
    String fechaNac,
    String email,
    String numCel,
    String direccion,
  ) async {
    try {
      // Generar la contraseña por defecto: "nombre_apellido"
      String password = "${nombre}_${apellido}";

      // Registrar usuario en Authentication
      await RegistroAuth.registrarUsuario(email, password);

      // Guardar usuario en la tabla 'usuario'
      final response = await SupabaseConfig.client.from('usuario').insert([
        {
          'nombre': nombre,
          'apellido': apellido,
          'rut': rut,
          'dv': dv,
          'fecha_nac': fechaNac,
          'email': email,
          'num_cel': numCel,
          'direccion': direccion,
          'estado': '047930a7-0dd1-4885-92da-7a849d353e9a',
          'rol': '3c8123d6-5a5e-4444-a8c9-352aa072a4d1',
          'ciudad': 1,
          'region': 2,
          'genero': 1,
          'fecha_creado': DateTime.now().toIso8601String(),
        }
      ]);

      if (response.hasError) {
        print("Error al agregar usuario en la base de datos: ${response.error!.message}");
      } else {
        print("Usuario agregado correctamente en la base de datos con contraseña por defecto.");
      }
    } catch (e) {
      print("Error inesperado: $e");
    }
  }
}
