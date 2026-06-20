import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SizedBox(width: 80, height: double.infinity, child: const Text('Menu')),
    );
  }
}
