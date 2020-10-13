import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/toast.dart';
import 'package:market_place/models/cart_model.dart';
import 'package:market_place/services/cart_services.dart';
import 'package:market_place/screens/cart/components/item_cart.dart';
import 'package:market_place/widgets/width_button.dart';

class Cart extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Market Place'),
        titleSpacing: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => Cart()),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<CartModel>>(
        stream: CartServices().cartProducts,
        builder: (context, snapshot) {
          return currentUser == null
              ? Center(child: Text('Please LogIn First!'))
              : !snapshot.hasData
                  ? Center(child: Text('No items in your cart!'))
                  : Stack(
                      children: <Widget>[
                        ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return CartItem(cart: snapshot.data[index]);
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: WidthButton(
                            width: size.width,
                            onTap: snapshot.data.length > 0
                                ? () => showDialog(context: context, child: confirmDialog(context))
                                : null,
                            title: 'PROCEED TO CHECKOUT',
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }

  AlertDialog confirmDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you wont to buy this items?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        WidthButton(
          width: 75,
          onTap: () {
            showToast(context, 'Thank you for using Market Place');
            Navigator.pop(context);
          },
          title: 'Yes',
        )
      ],
    );
  }
}
