import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final String currentRoute;
  const CustomNavbar({Key? key, required this.currentRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 767;
    final bool isBigScreen = screenWidth >= 767;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F2836),
      ),
      padding: const EdgeInsets.all(10),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isSmallScreen)
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                // Abre el drawer
                Scaffold.of(context).openDrawer();
              },
            ),
            isBigScreen
                ?
                Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2D3E),
                borderRadius: BorderRadius.circular(20),
              ),
              child:  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    style: const TextStyle(color: Colors.white),
                  )
             
         
                
              )
            ) : SizedBox.shrink(),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                  onPressed: () {},
                ),
                SizedBox(width: 10,),
                Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw4fHxkb2d8ZW58MHx8fHwxNjk5ODEzNTQxfDA&ixlib=rb-4.0.3&q=80&w=1080'),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Nombre usuario', style: TextStyle(fontSize: 14, color: Colors.white)),
                Text('Admin', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            SizedBox(width: 10,),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              onPressed: () {},
            ),
              ],
            ),
            
            
          ],
        ),
      
    );
  }
}