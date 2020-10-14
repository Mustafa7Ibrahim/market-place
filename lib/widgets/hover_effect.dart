import 'package:flutter/material.dart';

class HoverEffect extends StatelessWidget {
  const HoverEffect({@required this.onTap, @required this.child});

  final Function onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
