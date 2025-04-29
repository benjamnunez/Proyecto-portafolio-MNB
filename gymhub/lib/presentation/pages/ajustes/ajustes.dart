import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_responsive.dart';

class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  final List<Map<String, String>> allUsers = [
    {"nombre": "Sarah", "email": "19", "estatus": "Inhabilitado"},
    {"nombre": "Janine", "email": "43", "estatus": "Activo"},
    {"nombre": "William", "email": "27", "estatus": "Inhabilitado"},
    {"nombre": "Luis", "email": "32", "estatus": "Inhabilitado"},
    {"nombre": "Ana", "email": "28", "estatus": "Inhabilitado"},
    {"nombre": "Pedro", "email": "35", "estatus": "Vetado"},
    {"nombre": "Laura", "email": "22", "estatus": "Activo"},
    {"nombre": "Carlos", "email": "41", "estatus": "Inhabilitado"},
    {"nombre": "Sofía", "email": "25", "estatus": "Activo"},
    {"nombre": "Tomás", "email": "30", "estatus": "Inhabilitado"},
    {"nombre": "Elena", "email": "33", "estatus": "Activo"},
    {"nombre": "Mario", "email": "29", "estatus": "Activo"},
  ];

  int currentPage = 0;
  final int itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int startIndex = currentPage * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage).clamp(0, allUsers.length);
    List<Map<String, String>> currentUsers = allUsers.sublist(startIndex, endIndex);

    return ResponsiveScaffold(
      currentRoute: '/ajustes',
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        padding: const EdgeInsets.all(16),
        color: const Color(0xFF1F2836),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Usuarios', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Añadir usuario', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF8A958),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Tabla
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(const Color(0xFF323B4C)),
                  dataRowColor: MaterialStateProperty.all(const Color(0xFF2C3649)),
                  headingTextStyle: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                  dataTextStyle: const TextStyle(color: Colors.white),
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(label: Text('Nombre')),
                    DataColumn(label: Text('Correo')),
                    DataColumn(label: Text('Estatus')),
                    DataColumn(label: Text('')), // Columna para botón de opciones
                  ],
                  rows: List.generate(currentUsers.length, (index) {
                    final user = currentUsers[index];
                    final originalIndex = startIndex + index;

                    return DataRow(
                      cells: [
                        DataCell(Text(user["nombre"]!)),
                        DataCell(Text(user["email"]!)),
                        DataCell(Text(user["estatus"]!)),
                        DataCell(
                          Container(
                            alignment: Alignment.centerRight,
                            child: PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert, color: Colors.white),
                              color: const Color(0xFF2C3649),
                              onSelected: (value) {
                                if (value == 'vetar') {
                                  setState(() {
                                    user["estatus"] = "Vetado";
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${user["name"]} ha sido vetado')),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem<String>(
                                  value: 'vetar',
                                  child: Text('Vetar'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),

              // Paginación
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: currentPage > 0
                        ? () {
                            setState(() {
                              currentPage--;
                            });
                          }
                        : null,
                  ),
                  Text(
                    'Página ${currentPage + 1} de ${(allUsers.length / itemsPerPage).ceil()}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: endIndex < allUsers.length
                        ? () {
                            setState(() {
                              currentPage++;
                            });
                          }
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
