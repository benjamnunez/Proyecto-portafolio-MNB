import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_responsive.dart';
import 'package:gymhub/services/supabase_user.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<Map<String, dynamic>> generos = [];
  String? generoSeleccionado;

  List<Map<String, dynamic>> regiones = [];
  String? regionSeleccionada;

  List<Map<String, dynamic>> ciudades = [];
  String? ciudadSeleccionada;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final datosGeneros = await SupabaseUser.obtenerGeneros();
    final datosRegiones = await SupabaseUser.obtenerRegiones();
    if (mounted) {
      setState(() {
        generos = datosGeneros;
        regiones = datosRegiones;
        if (generos.isNotEmpty) {
          generoSeleccionado = generos.first['id_genero'].toString();
        }
        if (regiones.isNotEmpty) {
          regionSeleccionada = regiones.first['id_region'].toString();
          _cargarCiudades(regionSeleccionada!);
        }
      });
    }
  }

  Future<void> _cargarCiudades(String regionId) async {
    final datosCiudades = await SupabaseUser.obtenerCiudadesPorRegion(regionId);
    if (mounted) {
      setState(() {
        ciudades = datosCiudades;
        if (ciudades.isNotEmpty) {
          ciudadSeleccionada = ciudades.first['id_ciudad'].toString();
        } else {
          ciudadSeleccionada = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ResponsiveScaffold(
      currentRoute: '/usuarios',
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
          color: Color(0xFF1F2836),
          border: Border.all(
            color: const Color.fromARGB(100, 205, 205, 205),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('USUARIOS', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ElevatedButton(
                    onPressed: () => _mostrarFormulario(context),
                    child: Text("Crear Usuario"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarFormulario(BuildContext context) {
    final nombreController = TextEditingController();
    final apellidoController = TextEditingController();
    final emailController = TextEditingController();
    final rutController = TextEditingController();
    final dvController = TextEditingController();
    final fechaNacController = TextEditingController();
    final numCelController = TextEditingController();
    final direccionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Nuevo Usuario"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: nombreController, decoration: InputDecoration(labelText: "Nombre")),
                  TextField(controller: apellidoController, decoration: InputDecoration(labelText: "Apellido")),
                  TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
                  TextField(controller: rutController, decoration: InputDecoration(labelText: "RUT")),
                  TextField(controller: dvController, decoration: InputDecoration(labelText: "DV")),
                  TextField(controller: fechaNacController, decoration: InputDecoration(labelText: "Fecha de Nacimiento")),
                  TextField(controller: numCelController, decoration: InputDecoration(labelText: "Número")),
                  TextField(controller: direccionController, decoration: InputDecoration(labelText: "Dirección")),

                  DropdownButton<String>(
                    hint: Text("Selecciona un género"),
                    value: generoSeleccionado,
                    onChanged: (String? newValue) {
                      setState(() {
                        generoSeleccionado = newValue!;
                      });
                    },
                    items: generos.map<DropdownMenuItem<String>>((Map<String, dynamic> genero) {
                      return DropdownMenuItem<String>(
                        value: genero['id_genero'].toString(),
                        child: Text(genero['nombre']),
                      );
                    }).toList(),
                  ),

                  DropdownButton<String>(
                    hint: Text("Selecciona una región"),
                    value: regionSeleccionada,
                    onChanged: (String? newValue) async {
                      await _cargarCiudades(newValue!);
                      setState(() {
                        regionSeleccionada = newValue;
                        ciudadSeleccionada = null;
                      });
                    },
                    items: regiones.map<DropdownMenuItem<String>>((Map<String, dynamic> region) {
                      return DropdownMenuItem<String>(
                        value: region['id_region'].toString(),
                        child: Text(region['nombre']),
                      );
                    }).toList(),
                  ),

                  DropdownButton<String>(
                    hint: Text("Selecciona una ciudad"),
                    value: ciudadSeleccionada,
                    onChanged: (String? newValue) {
                      setState(() {
                        ciudadSeleccionada = newValue!;
                      });
                    },
                    items: ciudades.map<DropdownMenuItem<String>>((Map<String, dynamic> ciudad) {
                      return DropdownMenuItem<String>(
                        value: ciudad['id_ciudad'].toString(),
                        child: Text(ciudad['nombre']),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
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
                  numCelController.text,
                  direccionController.text,
                  generoSeleccionado ?? "1",
                  regionSeleccionada ?? "1",
                  ciudadSeleccionada ?? "1",
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
