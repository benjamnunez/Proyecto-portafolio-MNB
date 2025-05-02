import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_responsive.dart';
import 'package:gymhub/services/supabase_planes.dart'; // Asegúrate de que la ruta sea correcta
import 'package:gymhub/services/supabase_config.dart';

class PlanesPage extends StatefulWidget {
  const PlanesPage({super.key});

  @override
  State<PlanesPage> createState() => _PlanesPageState();
}

class _PlanesPageState extends State<PlanesPage> {
  late Future<List<Map<String, dynamic>>> _planesFuture;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _planesFuture = SupabasePlanes.obtenerPlanes();
  }

  void _refreshData() {
    setState(() {
      _planesFuture = SupabasePlanes.obtenerPlanes();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ResponsiveScaffold(
      currentRoute: '/planes',
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2836),
          border: Border.all(
            color: const Color.fromARGB(100, 205, 205, 205),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'PLANES',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () => _mostrarDialogoAgregarPlan(context),
                    child: const Text('Crear Plan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar plan',
                labelStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: const Color(0xFF2A3447),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => _refreshData(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _planesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || snapshot.data == null) {
                    return Center(
                      child: Text(
                        'Error al cargar planes: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  final planes = _filtrarPlanes(snapshot.data!);

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A3447),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: _HeaderText('Nombre')),
                          DataColumn(label: _HeaderText('Descripción')),
                          DataColumn(label: _HeaderText('Precio')),
                          DataColumn(label: _HeaderText('Duración (días)')),
                          DataColumn(label: _HeaderText('Estado')),
                          DataColumn(label: _HeaderText('Acciones')),
                        ],
                        rows: planes.map((plan) {
                          return DataRow(
                            cells: [
                              DataCell(_BodyText(plan['nombre_plan'] ?? '')),
                              DataCell(_BodyText(plan['descripcion'] ?? '')),
                              DataCell(_BodyText(plan['precio']?.toString() ?? '0')),
                              DataCell(_BodyText(plan['duracion']?.toString() ?? '')),
                              DataCell(
                                Icon(
                                  plan['estado'] == true ? Icons.check_circle : Icons.cancel,
                                  color: plan['estado'] == true ? Colors.green : Colors.red,
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () => _mostrarDialogoEditarPlan(context, plan),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _confirmarEliminacion(context, plan),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        headingRowColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) => const Color(0xFF3A475C),
                        ),
                        dataRowColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) => const Color(0xFF2A3447),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _filtrarPlanes(List<Map<String, dynamic>> planes) {
    if (_searchController.text.isEmpty) return planes;
    return planes.where((plan) =>
      (plan['nombre_plan']?.toString().toLowerCase().contains(
            _searchController.text.toLowerCase()) ?? false) ||
      (plan['descripcion']?.toString().toLowerCase().contains(
            _searchController.text.toLowerCase()) ?? false),
    ).toList();
  }

  void _mostrarDialogoAgregarPlan(BuildContext context) {
    // Implementar diálogo para agregar nuevo plan
  }

  void _mostrarDialogoEditarPlan(BuildContext context, Map<String, dynamic> plan) {
    // Implementar diálogo para editar plan
  }

  Future<void> _confirmarEliminacion(BuildContext context, Map<String, dynamic> plan) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Eliminar el plan "${plan['nombre_plan']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        // Implementar eliminación usando SupabasePlanes
        await SupabaseConfig.client
            .from('plan_gimnasio')
            .delete()
            .eq('nombre_plan', plan['nombre_plan']);
        _refreshData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Plan "${plan['nombre_plan']}" eliminado')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar: $e')),
        );
      }
    }
  }
}

// Widgets personalizados para mantener consistencia en los estilos
class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: Colors.white70));
  }
}

class _BodyText extends StatelessWidget {
  final String text;
  const _BodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: Colors.white));
  }
}