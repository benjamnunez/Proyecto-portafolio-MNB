import 'supabase_config.dart';
import 'registro_auth.dart';

class SupabaseUser {
  // Obtener géneros desde la base de datos
  static Future<List<Map<String, dynamic>>> obtenerGeneros() async {
    try {
      final List<dynamic> response = await SupabaseConfig.client.from('genero').select('id_genero, nombre');

      return response.cast<Map<String, dynamic>>();
    } catch (error) {
      print("Error al obtener géneros: $error");
      return [];
    }
  }

  // Obtener regiones desde la base de datos
  static Future<List<Map<String, dynamic>>> obtenerRegiones() async {
    try {
      final List<dynamic> response = await SupabaseConfig.client.from('region').select('id_region, nombre');

      return response.map<Map<String, dynamic>>((region) {
        String nombreCorto = region['nombre'];
        if (nombreCorto.length > 15) {
          nombreCorto = nombreCorto.substring(0, 15) + "..."; // Reducimos nombres largos
        }
        return {
          'id_region': region['id_region'].toString(),
          'nombre': nombreCorto
        };
      }).toList();
    } catch (error) {
      print("Error al obtener regiones: $error");
      return [];
    }
  }

  // Obtener ciudades según la región seleccionada
  static Future<List<Map<String, dynamic>>> obtenerCiudadesPorRegion(String regionId) async {
    try {
      final List<dynamic> response = await SupabaseConfig.client
          .from('ciudad')
          .select('id_ciudad, nombre')
          .eq('region', int.parse(regionId)); // Filtrar por región

      return response.cast<Map<String, dynamic>>();
    } catch (error) {
      print("Error al obtener ciudades: $error");
      return [];
    }
  }

  // Agregar un usuario con género, región y ciudad seleccionados
  static Future<void> agregarUsuario(
    String nombre,
    String apellido,
    String rut,
    String dv,
    String fechaNac,
    String email,
    String numCel,
    String direccion,
    String generoId,
    String regionId,
    String ciudadId,
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
          'ciudad': int.parse(ciudadId), // Guarda la ciudad seleccionada
          'region': int.parse(regionId), // Guarda la región seleccionada
          'genero': int.parse(generoId), // Guarda el género seleccionado
          'fecha_creado': DateTime.now().toIso8601String(),
        }
      ]);

      if (response.isEmpty) {
        print("Error al agregar usuario en la base de datos.");
      } else {
        print("Usuario agregado correctamente en la base de datos.");
      }
    } catch (error) {
      print("Error inesperado: $error");
    }
  }
}
