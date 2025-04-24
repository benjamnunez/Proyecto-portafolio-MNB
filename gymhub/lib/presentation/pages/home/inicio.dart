import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_responsive.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ResponsiveScaffold(
    currentRoute: '/inicio',
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
          Text('INICIO', style: TextStyle(color: Colors.white, fontSize: 20)),
          
        ],
      ),
    ),
  ])
  
  )
    );
  }
}
