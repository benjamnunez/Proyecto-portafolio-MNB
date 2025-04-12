import 'package:flutter/material.dart';
import 'package:gymhub/marco/componentes/menu_lateral.dart';
import 'package:gymhub/marco/componentes/navBar.dart';
class Usuarios extends StatelessWidget {
  const Usuarios({Key? key}) : super(key: key);
/*/Users/mcarvallom/flutter/bin/flutter run*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: Container(
        decoration: BoxDecoration(
        color: Color(0xFF1F2836),
        border: Border.all(
          color: const Color.fromARGB(100, 205, 205, 205),
        ),
      ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              MenuLateralWidget(currentRoute: '/usuarios'),
              Column(
                children: [
                  CustomNavbar(),
                  Text("Hola, GymHub!", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 16),
                  Text("Esta es la pantalla de usuarios", style: TextStyle(color: Colors.white)),
                ],
              )
            ]
          ),
        ),
      ),
    );}}