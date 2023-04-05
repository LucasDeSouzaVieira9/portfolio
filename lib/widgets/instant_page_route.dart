import 'package:flutter/material.dart';

class InstantPageRoute<T> extends MaterialPageRoute<T> {
  InstantPageRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(
          builder: builder,
          settings: settings,
        );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
