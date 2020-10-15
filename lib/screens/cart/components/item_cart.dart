import 'package:flutter/material.dart';
import 'package:market_place/models/cart_model.dart';
import 'package:market_place/services/cart_services.dart';

class CartItem extends StatefulWidget {
  CartItem({this.cart, this.size});
  final CartModel cart;
  final Size size;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  CartServices _cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 14.0),
          itemImage(context, widget.size),
          SizedBox(width: 14.0),
          itemInfo(context),
          SizedBox(width: 12.0),
          itemPrice(context),
        ],
      ),
    );
  }

  Expanded itemInfo(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 12.0),
          Text(
            widget.cart.itemName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).iconTheme.color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 4.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Saller By. ', style: Theme.of(context).textTheme.caption),
                TextSpan(
                  text: '${widget.cart.sallerName}',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.0),
          numberOfItems(context),
          SizedBox(height: 4.0),
        ],
      ),
    );
  }

  Row numberOfItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            size: 30.0,
            color: Theme.of(context).primaryColor,
          ),
          disabledColor: Colors.grey,
          onPressed: widget.cart.numberOfItems <= 1
              ? null
              : () {
                  _cartServices.reduceitemNumber(
                    itemId: widget.cart.itemId,
                    itemImg: widget.cart.itemImg,
                    itemName: widget.cart.itemName,
                    itemPrice: widget.cart.itemPrice,
                    sallerName: widget.cart.sallerName,
                    numberOfItems: widget.cart.numberOfItems,
                  );
                },
        ),
        Text(
          '${widget.cart.numberOfItems.toString()} Item',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        IconButton(
          icon: Icon(
            Icons.add_circle,
            size: 30.0,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            _cartServices.addNewItemToCart(
              itemId: widget.cart.itemId,
              itemImg: widget.cart.itemImg,
              itemName: widget.cart.itemName,
              itemPrice: widget.cart.itemPrice,
              sallerName: widget.cart.sallerName,
              numberOfItems: widget.cart.numberOfItems,
            );
          },
        ),
      ],
    );
  }

  Expanded itemPrice(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Text(
        '\$${widget.cart.itemPrice}',
        style:
            Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }

  Expanded itemImage(BuildContext context, Size size) {
    return Expanded(
      flex: 1,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.network(
            widget.cart.itemImg,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              return loadingProgress == null ? child : Center(child: CircularProgressIndicator());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_shopping_cart,
              size: 34.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => _cartServices.removeItemFromCart(itemId: widget.cart.itemId),
          ),
        ],
      ),
    );
  }
}
