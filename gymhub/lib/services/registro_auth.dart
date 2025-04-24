import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';

class RegistroAuth {
  static Future<void> registrarUsuario(String email, String password) async {
    try {
      final response = await SupabaseConfig.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.session == null) {
        print("Error al registrar usuario en autenticación.");
      } else {
        print("Usuario registrado correctamente en autenticación.");
      }
    } catch (e) {
      print("Error inesperado en autenticación: $e");
    }
  }
}
