import 'package:flutter/material.dart';
import 'package:gymhub/marco/componentes/menu_lateral.dart';
import 'package:gymhub/marco/componentes/navBar.dart';
class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);
/*/Users/mcarvallom/flutter/bin/flutter run*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
              MenuLateralWidget(currentRoute: '/inicio'),
              Flexible(
                child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomNavbar(),
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
    );}}