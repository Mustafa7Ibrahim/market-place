import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  final Function numOfItem;

  const CartCounter({Key key, this.numOfItem}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutLineButton(
          icon: Icons.remove,
          onTap: () {
            setState(
              () => numOfItems > 1 ? setState(() => numOfItems--) : null,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: Text(
            numOfItems.toString().padLeft(2, '0'),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutLineButton(
            icon: Icons.add,
            onTap: () {
              setState(() {
                numOfItems++;
              });
            })
      ],
    );
  }

  buildOutLineButton({IconData icon, Function onTap}) {
    return SizedBox(
      height: 32,
      width: 40,
      child: OutlineButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon),
      ),
    );
  }
}
