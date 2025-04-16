import 'package:flutter/material.dart';
import 'package:gymhub/marco/componentes/menu_lateral.dart';
import 'package:gymhub/marco/componentes/navBar.dart';
class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
    State<Inicio> createState() => _InicioAppState();
  }
                                /*/Users/mcarvallom/flutter/bin/flutter run*/
  class _InicioAppState extends State<Inicio> {
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
        color: Color(0xFF1A1F23),
        border: Border.all(
          color: const Color.fromARGB(100, 205, 205, 205),
        ),
      ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (!isSmallScreen)
                MenuLateralWidget(currentRoute: '/inicio'),
              Flexible(
                child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomNavbar(currentRoute: '/inicio'),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hola, GymHub!", 
                            style: TextStyle(color: Colors.white, fontSize: 24)),
                        SizedBox(height: 16),
                        Text("Esta es la pantalla de inicio", 
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ))
            ]
          ),
        ),
      ),
    );
    }
    }



