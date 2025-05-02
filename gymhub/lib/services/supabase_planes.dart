import 'supabase_config.dart';

class SupabasePlanes {
  static Future<List<Map<String, dynamic>>> obtenerPlanes() async {
    try {
      final response = await SupabaseConfig.client
          .from('plan_gimnasio')
          .select('*')
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
}