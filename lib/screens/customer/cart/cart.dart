import 'package:flutter/material.dart';
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
    getCurrentUserId();
    super.initState();
  }

  getCurrentUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('user'));
    // return the current user id
    return setState(() => currentUserId = sharedPreferences.getString('user'));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
      bottomNavigationBar: WidthButton(
        width: size.width,
        onTap: () {},
        title: 'PROCEED TO CHECKOUT',
      ),
      body: StreamBuilder<List<CartModel>>(
        stream: cartCollection
            .document(currentUserId)
            .collection('MyCart')
            .snapshots()
            .map(_cartServices.cartListMap),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading(
              color: Theme.of(context).primaryColor,
              height: size.height,
              width: size.width,
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return CartItem(cart: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
