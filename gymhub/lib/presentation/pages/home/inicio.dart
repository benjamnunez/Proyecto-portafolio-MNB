import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_lateral.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final bool isSmallScreen = screenWidth < 767;
    return Scaffold(
      key: _scaffoldKey,
    drawer: isSmallScreen ? MenuLateralWidget(currentRoute: '/inicio') : null,
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
            MenuLateralWidget(currentRoute: '/inicio'),
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
                      Text('INICIO',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
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