import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F2836),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2D3E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw4fHxkb2d8ZW58MHx8fHwxNjk5ODEzNTQxfDA&ixlib=rb-4.0.3&q=80&w=1080'),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Nombre usuario', style: TextStyle(fontSize: 14, color: Colors.white)),
              Text('Admin', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
