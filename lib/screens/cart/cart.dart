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
        title: Text(
          'M-Place',
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        titleSpacing: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
        ],
      ),
      body: StreamBuilder<List<CartModel>>(
        stream: CartServices().cartProducts,
        builder: (context, snapshot) {
          return currentUser == null
              ? Center(child: Text('Please LogIn First!'))
              : !snapshot.hasData
                  ? Center(child: Text('No items in your cart!'))
                  : Scaffold(
                      bottomNavigationBar: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text('Total Price:'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    '\$4545.55',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            WidthButton(
                              width: size.width,
                              onTap: snapshot.data.length > 0
                                  ? () =>
                                      showDialog(context: context, child: confirmDialog(context))
                                  : null,
                              title: 'CHECKOUT',
                            ),
                          ],
                        ),
                      ),
                      body: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return CartItem(cart: snapshot.data[index], size: size);
                        },
                      ),
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
