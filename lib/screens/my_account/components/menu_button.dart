import 'package:flutter/material.dart';
import 'package:market_place/widgets/hover_effect.dart';

class MenuButton extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData icon;

  const MenuButton({this.onTap, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return HoverEffect(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 6.0),
            Text(title),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
