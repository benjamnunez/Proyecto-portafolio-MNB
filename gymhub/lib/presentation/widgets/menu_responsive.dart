import 'package:flutter/material.dart';
import 'package:gymhub/presentation/widgets/menu_lateral.dart';


class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final String currentRoute;
  

  const ResponsiveScaffold({
    Key? key,
    required this.body,
    required this.currentRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth <= 767;

    return Scaffold(
      appBar: isSmallScreen
          ? AppBar(
              title: Text(currentRoute.toUpperCase().replaceFirst('/', ''), style: TextStyle(color: Color(0xFFF8A958)),),
              backgroundColor: Color(0xFF1F2836),
              iconTheme: IconThemeData(color: Colors.white),
            )
          : null,
      drawer: isSmallScreen
          ? Drawer(
              child: MenuLateralWidget(currentRoute: currentRoute),
            )
          : null,
      body: Row(
        children: [
          if (!isSmallScreen)
            MenuLateralWidget(currentRoute: currentRoute), // Sidebar para pantallas grandes
          Expanded(child: body), // Contenido principal
        ],
      ),
    );
  }
}
