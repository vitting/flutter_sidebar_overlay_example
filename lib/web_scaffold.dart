import 'package:flutter/material.dart';
import 'package:flutter_sidebar_overlay_example/background_overlay.dart';
import 'package:flutter_sidebar_overlay_example/menu.dart';
import 'package:flutter_sidebar_overlay_example/sidebar_overlay.dart';
import 'package:flutter_sidebar_overlay_example/topbar.dart';

class WebScaffold extends StatefulWidget {
  final Widget content;
  final Widget? floatingSidebarContent;
  final OverlayPortalController? sidebarController;
  final bool showSidebarPageOverlay;
  final bool sidebarCanBeResized;
  const WebScaffold({
    super.key,
    required this.content,
    this.floatingSidebarContent,
    this.sidebarController,
    this.showSidebarPageOverlay = true,
    this.sidebarCanBeResized = false,
  });

  @override
  State<WebScaffold> createState() => _WebScaffoldState();
}

class _WebScaffoldState extends State<WebScaffold> {
  late final OverlayPortalController _sidebarController;

  @override
  void initState() {
    super.initState();
    _sidebarController = widget.sidebarController ?? OverlayPortalController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Topbar(),
          Expanded(
            child: Row(
              children: [
                Menu(),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.yellow,
                          child: OverlayPortal(
                            controller: _sidebarController,
                            overlayChildBuilder: (context) {
                              return Stack(
                                children: [
                                  if (widget.showSidebarPageOverlay) BackgroundOverlay(onTap: _sidebarController.hide),
                                  SidebarOverlay(
                                    onClose: _sidebarController.hide,
                                    content: widget.floatingSidebarContent,
                                    canBeResized: widget.sidebarCanBeResized,
                                  ),
                                ],
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Expanded(child: widget.content)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
