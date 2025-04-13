import 'package:flutter/material.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final String route;

  MenuItem({required this.icon, required this.title, required this.route});
}

final List<MenuItem> menuItems = [
  MenuItem(icon: Icons.home_rounded, title: 'Inicio', route: '/inicio'),
  MenuItem(icon: Icons.person_add_alt, title: 'Gestión usuarios', route: '/usuarios'),
  MenuItem(icon: Icons.lan, title: 'Planes', route: '/planes'),
  MenuItem(icon: Icons.pie_chart, title: 'Mis Finanzas', route: '/finanzas'),
  MenuItem(icon: Icons.notifications_active, title: 'Notificaciones', route: '/notificaciones'),
  MenuItem(icon: Icons.sports_gymnastics, title: 'Rutinas', route: '/rutinas'),
  MenuItem(icon: Icons.fitness_center, title: 'Maquinas', route: '/maquinas'),
  MenuItem(icon: Icons.groups_rounded, title: 'Mi equipo', route: '/equipo'),
  MenuItem(icon: Icons.groups_rounded, title: 'Suscriptores', route: '/suscriptores'),
  MenuItem(icon: Icons.devices, title: 'Mis servicios', route: '/servicios'),
  MenuItem(icon: Icons.calendar_month, title: 'Agenda', route: '/agenda'),
  MenuItem(icon: Icons.monetization_on_outlined, title: 'Pagos', route: '/pagos'),
  MenuItem(icon: Icons.insert_chart_outlined, title: 'Reportes', route: '/reportes'),
  MenuItem(icon: Icons.settings_sharp, title: 'Ajustes', route: '/ajustes'),
];