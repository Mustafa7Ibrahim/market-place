import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/cart_model.dart';
import 'package:market_place/services/cart_services.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/item_cart.dart';
import 'package:market_place/widgets/width_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartServices _cartServices = CartServices();
  var currentUserId;

  @override
  void initState() {
    // first thing happen is geting the user id
    getCurrentUserId();
    super.initState();
  }

  // this function geting the current user id from shared prefrences
  getCurrentUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('user'));
    // return the current user id
    return setState(() => currentUserId = sharedPreferences.getString('user'));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //==================================================================//
    // using stream builder to get the cart data from firebase firestore//
    //==================================================================//
    return StreamBuilder<List<CartModel>>(
      stream: cartCollection
          .document(currentUserId)
          .collection('MyCart')
          .snapshots()
          .map(_cartServices.cartListMap),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Cart',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            centerTitle: true,
          ),
          //=======================================================//
          // if the data not ready yet, we showing a loading screan//
          //=======================================================//
          body: !snapshot.hasData
              ? Loading(
                  color: Theme.of(context).primaryColor
                )
              : Stack(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        /*
                          when data is ready we pase every item to show in 
                          cart item widget.
                        */
                        return CartItem(cart: snapshot.data[index]);
                      },
                    ),
                    /*
                      align the checkout button in the bottom
                      of the screan.
                    */
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: WidthButton(
                        width: size.width,
                        onTap: snapshot.data.length > 0
                            ? () {
                                showDialog(
                                  context: context,
                                  child: confirmDialog(context),
                                );
                              }
                            : null,
                        title: 'PROCEED TO CHECKOUT',
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  /*
    this function show a confirmation dialog when the user cleck
    on the checkout button 
  */
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
            Fluttertoast.showToast(msg: 'Thank you for using Market Place');
            Navigator.pop(context);
          },
          title: 'Yes',
        )
      ],
    );
  }
}
