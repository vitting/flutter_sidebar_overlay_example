import 'package:flutter/material.dart';
import 'package:flutter_sidebar_overlay_example/web_scaffold.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _sidebarController = OverlayPortalController();
  bool _showSidebarPageOverlay = true;

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      sidebarController: _sidebarController,
      showSidebarPageOverlay: _showSidebarPageOverlay,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Content'),
          Material(
            child: SwitchListTile(
              title: Text('Show page overlay when sidebar is open'),
              value: _showSidebarPageOverlay,
              onChanged: (value) {
                setState(() {
                  _showSidebarPageOverlay = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _sidebarController.toggle();
            },
            child: Text('Toggle Sidebar'),
          ),
        ],
      ),
      floatingSidebarContent: ListView.separated(
        itemCount: 50,
        shrinkWrap: true,
        primary: false,
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemBuilder: (context, index) => Material(
          child: ListTile(title: Text('Item $index'), tileColor: Colors.amber),
        ),
      ),
    );
  }
}
