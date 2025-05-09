import 'supabase_config.dart';

class SupabasePlanes {
  
  //Método para obtener los planes desde la base de datos
  static Future<List<Map<String, dynamic>>> obtenerPlanes() async {
    try {
      final response = await SupabaseConfig.client
          .from('plan_gimnasio')
          .select('''*,
          estado: estado(nombre)''')
          .order('precio', ascending: true);

      if (response.isEmpty) {
        print("La respuesta está vacía");
        return [];
      }

      print("Datos obtenidos: $response"); // Debug
      return List<Map<String, dynamic>>.from(response);
    } catch (error) {
      print("Error al obtener planes: $error");
      rethrow; // Importanté para que FutureBuilder detecte el error
    }
  }


//Método para agregar un nuevp plan a la base de datos
  static Future<String> agregarPlan({
    required String nombre,
    required String descripcion,
    required int precio,
    required int duracion,
    required String idEstado,
  }) async {
    try {
      final response = await SupabaseConfig.client
      .from('plan_gimnasio')
      .insert({
        'nombre_plan': nombre,
        'descripcion': descripcion,
        'precio': precio,
        'duracion': duracion,
        'estado': idEstado, // FK a estados_plan
      }).select('nombre_plan'); // Retornamos solo el nombre del nuevo registro

      if (response.isEmpty) {
        throw Exception('No se recibió respuesta del servidor');
      }

      // Extraemos el ID del nuevo plan
      final nuevoId = response[0]['nombre_plan'] as String;
      print('Plan creado con ID: $nuevoId');
      return nuevoId;
    } catch (e) {
      print('Error al agregar plan: $e');
      throw Exception('No se pudo crear el plan: ${e.toString()}');
    }
  }
}
