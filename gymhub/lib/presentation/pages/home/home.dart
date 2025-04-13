import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_lateral.dart';
class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);
  
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
            children: [
              MenuLateralWidget(currentRoute: '/inicio'),
              Column(
                children: [
                  Text("Hola, GymHub!", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 16),
                  Text("Esta es la pantalla de inicio", style: TextStyle(color: Colors.white)),
                ],
              )
            ]
          ),
        ),
      ),
    );}}