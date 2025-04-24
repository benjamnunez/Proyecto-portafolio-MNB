import 'package:flutter/material.dart';

import 'menu_items.dart';
import 'package:gymhub/services/services.dart'; // Asegúrate que el path sea correcto

class MenuLateralWidget extends StatelessWidget {
  final String currentRoute;

  const MenuLateralWidget({Key? key, required this.currentRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0xFF1F2836),
        border: Border.all(
          color: const Color.fromARGB(100, 205, 205, 205),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'LOGO NOSOTROS',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF718096)),
            ),
          ),
          Divider(
            height: 1.0,
            thickness: 2.0,
            color: const Color.fromARGB(100, 205, 205, 205),
          ),
          Expanded(
            child: ListView(
              children: menuItems.map((item) => _buildMenuItem(context, item)).toList(),
            ),
          ),
          _buildUserProfile(context),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    final bool isSelected = currentRoute == item.route;
    final Color activeColor = Theme.of(context).primaryColor;
    final Color inactiveColor = Color(0xFF718096);

    return InkWell(
      onTap: () {
        if (!isSelected) {
          Navigator.pushNamed(context, item.route);
        }
      },
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            children: [
              Icon(item.icon, color: isSelected ? activeColor : inactiveColor, size: 24.0),
              SizedBox(width: 8),
              Text(item.title,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: isSelected ? activeColor : inactiveColor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/seed/596/600'),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre', style: TextStyle(color: Colors.white)),
                Text('Rol', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: InkWell(
        onTap: () => AuthService.logout(context), // Aquí se llama al servicio
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFF2D3748),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.redAccent),
              SizedBox(width: 8),
              Text('Cerrar sesión', style: TextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
      ),
    );
  }
}
