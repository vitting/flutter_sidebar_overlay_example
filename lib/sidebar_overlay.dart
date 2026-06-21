import 'package:flutter/material.dart';

class SidebarOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final Widget? content;
  const SidebarOverlay({super.key, required this.onClose, this.content});

  final _sidebarWidth = 400.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 80,
      bottom: 0,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: _sidebarWidth, end: 0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        builder: (context, slideValue, child) {
          return Transform.translate(offset: Offset(slideValue, 0), child: child);
        },
        child: Container(
          width: _sidebarWidth,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 80,
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sidebar'),
                    IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              Expanded(child: SingleChildScrollView(child: content ?? SizedBox())),
            ],
          ),
        ),
      ),
    );
  }
}
