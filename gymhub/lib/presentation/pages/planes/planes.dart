import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_responsive.dart';

class Planes extends StatefulWidget {
const Planes({super.key});

@override
State<Planes> createState() => _PlanesState();
}

class _PlanesState extends State<Planes> {
@override
Widget build(BuildContext context) {
return ResponsiveScaffold(
    currentRoute: '/planes',
    body: Center(
    child: Text('Contenido principal aquí'),
),
);
}
}