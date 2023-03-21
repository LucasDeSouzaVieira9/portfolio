import 'dart:math';

import 'package:flutter/material.dart';

///
/// This widget should prevent a child widget from infinitely shrinking in width.
/// The child widget should be allowed to overflow past a minimum width, and the off screen
/// widget should be allowed to scroll into view.
class AppSizeLimiter extends StatefulWidget {
  final Widget child;

  const AppSizeLimiter({Key? key, required this.child}) : super(key: key);

  @override
  State<AppSizeLimiter> createState() => _AppSizeLimiterState();
}

class _AppSizeLimiterState extends State<AppSizeLimiter> {
  final _minWidth = 1000.0;
  final _minHeight = 600.0;
  ScrollController? _horizontalScrollController;

  @override
  void initState() {
    super.initState();
    _horizontalScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width >= _minWidth && size.height >= _minHeight) return widget.child;

    return Builder(builder: (context) {
      final width = max(_minWidth, size.width);
      final height = max(_minHeight, size.height);

      return Scrollbar(
        controller: _horizontalScrollController,
        thumbVisibility: true,
        interactive: true,
        child: SingleChildScrollView(
          controller: _horizontalScrollController,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedOverflowBox(
              size: Size(width, height),
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: width,
                height: height,
                child: widget.child,
              ),
            ),
          ),
        ),
      );
      // });
    });
  }
}
