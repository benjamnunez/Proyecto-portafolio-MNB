import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_responsive.dart';
import 'package:gymhub/services/supabase_planes.dart';
import 'package:gymhub/services/supabase_config.dart';

class PlanesPage extends StatefulWidget {
  const PlanesPage({super.key});

  @override
  State<PlanesPage> createState() => _PlanesPageState();
}

class _PlanesPageState extends State<PlanesPage> {
  late Future<List<Map<String, dynamic>>> _planesFuture;
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _precioController = TextEditingController();
  final _duracionController = TextEditingController();
  String? _selectedEstado;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _planesFuture = SupabasePlanes.obtenerPlanes();
    });
  }

  Future<List<Map<String, dynamic>>> _obtenerEstadosDisponibles() async {
    final response = await SupabaseConfig.client
        .from('estado')
        .select('id_estado, nombre')
        .inFilter('nombre', ['ACTIVO', 'INACTIVO'])
        .order('nombre');

    return List<Map<String, dynamic>>.from(response);
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
                          DataColumn(label: _HeaderText('Duración (meses)')),
                          DataColumn(label: _HeaderText('Estado')),
                          DataColumn(label: _HeaderText('Acciones')),
                        ],
                        rows: planes.map((plan) {
                          final estado = plan['estado'] as Map<String, dynamic>?;
                          return DataRow(
                            cells: [
                              DataCell(_BodyText(plan['nombre_plan']?.toString() ?? '')),
                              DataCell(_BodyText(plan['descripcion']?.toString() ?? '')),
                              DataCell(_BodyText(plan['precio']?.toString() ?? '0')),
                              DataCell(_BodyText(plan['duracion']?.toString() ?? '')),
                              DataCell(
                                Chip(
                                  label: Text(
                                    estado?['nombre']?.toString() ?? 'Desconocido',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: estado?['nombre'] == 'ACTIVO' 
                                      ? Colors.green 
                                      : Colors.red,
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

  void _mostrarDialogoAgregarPlan(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nuevo Plan', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF2A3447),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Plan',
                      labelStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descripcionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      labelStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.white),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _precioController,
                          decoration: const InputDecoration(
                            labelText: 'Precio (\$)',
                            labelStyle: TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese un precio';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Debe ser un número';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _duracionController,
                          decoration: const InputDecoration(
                            labelText: 'Duración (meses)',
                            labelStyle: TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese la duración';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Debe ser un número';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _obtenerEstadosDisponibles(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return const Text('Error al cargar estados',
                            style: TextStyle(color: Colors.red));
                      }
                      final estados = snapshot.data ?? [];
                      return DropdownButtonFormField<String>(
                        value: _selectedEstado,
                        decoration: const InputDecoration(
                          labelText: 'Estado',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(),
                        ),
                        items: estados.map((estado) {
                          return DropdownMenuItem<String>(
                            value: estado['nombre'] as String,
                            child: Text(
                              estado['nombre'] as String,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedEstado = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Seleccione un estado';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () => _agregarPlan(context),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _agregarPlan(BuildContext context) async {
    if (_formKey.currentState!.validate() && _selectedEstado != null) {
      try {
        // Mostrar indicador de carga
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );

        // Obtener el ID del estado seleccionado
        final estadoResponse = await SupabaseConfig.client
            .from('estado')
            .select('id_estado')
            .eq('nombre', _selectedEstado!)
            .single();

        final idEstado = estadoResponse['id_estado'] as String;

        // Insertar el nuevo plan
        await SupabasePlanes.agregarPlan(
          nombre: _nombreController.text.toUpperCase(),
          descripcion: _descripcionController.text,
          precio: int.parse(_precioController.text),
          duracion: int.parse(_duracionController.text),
          idEstado: idEstado,
        );

        // Cerrar diálogos
        Navigator.pop(context); // Cerrar loading
        Navigator.pop(context); // Cerrar formulario

        // Mostrar notificación
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Plan creado exitosamente!'),
            backgroundColor: Colors.green,
          ),
        );

        // Actualizar datos y limpiar formulario
        _refreshData();
        _limpiarFormulario();
      } catch (e) {
        Navigator.pop(context); // Cerrar loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al crear plan: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _limpiarFormulario() {
    _nombreController.clear();
    _descripcionController.clear();
    _precioController.clear();
    _duracionController.clear();
    _selectedEstado = null;
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

  void _mostrarDialogoEditarPlan(BuildContext context, Map<String, dynamic> plan) {
    // Implementar lógica de edición similar a agregar
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
        await SupabaseConfig.client
            .from('plan_gimnasio')
            .delete()
            .eq('id_plan', plan['id_plan']);
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