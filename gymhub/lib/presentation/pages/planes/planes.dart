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
    body: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Por si hay muchas columnas
        child: DataTable(
            columns: [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('Edad')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('1')),
              DataCell(Text('Juan')),
              DataCell(Text('25')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Ana')),
              DataCell(Text('30')),
            ]),
            DataRow(cells: [
              DataCell(Text('3')),
              DataCell(Text('Carlos')),
              DataCell(Text('28')),
            ]),
          ],
        ),
      ),
    );
  }
}
