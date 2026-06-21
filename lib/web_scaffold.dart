import 'package:flutter/material.dart';
import 'package:flutter_sidebar_overlay_example/menu.dart';
import 'package:flutter_sidebar_overlay_example/topbar.dart';

class WebScaffold extends StatefulWidget {
  final Widget content;
  final Widget? floatingSidebarContent;
  final OverlayPortalController? sidebarController;
  final bool showSidebarPageOverlay;
  const WebScaffold({
    super.key,
    required this.content,
    this.floatingSidebarContent,
    this.sidebarController,
    this.showSidebarPageOverlay = true,
  });

  @override
  State<WebScaffold> createState() => _WebScaffoldState();
}

class _WebScaffoldState extends State<WebScaffold> {
  final _sidebarWidth = 400.0;
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
                                  if (widget.showSidebarPageOverlay)
                                    GestureDetector(
                                      onTap: _sidebarController.hide,
                                      child: TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 0, end: 1),
                                        duration: const Duration(milliseconds: 250),
                                        curve: Curves.easeOutCubic,
                                        builder: (context, opacityValue, child) {
                                          return Container(color: Colors.black.withAlpha(100));
                                        },
                                      ),
                                    ),
                                  Positioned(
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
                                                  IconButton(onPressed: _sidebarController.hide, icon: const Icon(Icons.close)),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(child: widget.floatingSidebarContent ?? SizedBox()),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
