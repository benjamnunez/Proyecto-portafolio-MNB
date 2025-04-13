import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_lateral.dart';

class UserApp extends StatefulWidget {
  const UserApp({super.key});

  
  @override
  State<UserApp> createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
 @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final bool isSmallScreen = screenWidth < 767;

  return Scaffold(
    key: _scaffoldKey,
    drawer: isSmallScreen ? MenuLateralWidget(currentRoute: '/usuario') : null,
    body: Container(
      decoration: BoxDecoration(
        color: Color(0xFF1F2836),
        border: Border.all(
          color: const Color.fromARGB(100, 205, 205, 205),
        ),
      ),
      child: Row(
        children: [
          // Sidebar solo en pantallas grandes
          if (!isSmallScreen)
            MenuLateralWidget(currentRoute: '/usuario'),

          // Contenido principal
          Expanded(
            child: Column(
              children: [
                // Mostrar botón menú solo si es pantalla pequeña
                if (isSmallScreen)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _scaffoldKey.currentState?.openDrawer(),
                        child: Icon(Icons.menu, color: Colors.white),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Usuarios',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      ElevatedButton.icon(
                        onPressed: () {
                          // lógica para añadir usuario
                        },
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text(
                          'Añadir usuario',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF8A958),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}