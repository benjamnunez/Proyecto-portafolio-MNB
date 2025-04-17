import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_responsive.dart';

class UserApp extends StatefulWidget {
  const UserApp({super.key});

  
  @override
  State<UserApp> createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  @override
Widget build(BuildContext context) {
double screenWidth = MediaQuery.of(context).size.width;
final bool isSmallScreen = screenWidth <= 767;

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
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Usuarios', style: TextStyle(color: Colors.white, fontSize: 20)),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add, color: Colors.white),
            label: Text('Añadir usuario', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF8A958),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    ),

    Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color(0xFF1F2836),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black26,
          blurRadius: 4,
          offset: Offset(2, 2)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
          decoration: InputDecoration(
            labelText: 'Buscar',
            hintText: 'Ingrese nombre',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            
            )
          ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("NOMBRE", style: TextStyle(color: Colors.white)),
            Text("CORREO",style: TextStyle(color: Colors.white)),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.edit, color: Colors.white)),
              ],
              
            )
            
          ],
        )
      ],
    ),
  )
]  
),
)
);
}
}