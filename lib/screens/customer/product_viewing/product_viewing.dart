import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../cart/cart.dart';
import '../../../services/cart_services.dart';
import '../../../widgets/list_of_images.dart';
import 'components/cart_counter.dart';
import 'components/add_to_cart.dart';

class ProductViewing extends StatefulWidget {
  final Product product;

  const ProductViewing({Key key, this.product}) : super(key: key);

  @override
  _ProductViewingState createState() => _ProductViewingState();
}

class _ProductViewingState extends State<ProductViewing> {
  CartServices _cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.1,
                    right: 18.0,
                    left: 18.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      buildSellerAndQuantity(context, size),
                      SizedBox(height: 9.0),
                      buildDiscription(),
                      SizedBox(height: 9.0),
                      buildCounterWithFavBtn(),
                      SizedBox(height: 9.0),
                      AddToCartAndBuy(
                        product: widget.product,
                        cartServices: _cartServices,
                      ),
                      SizedBox(height: 9.0),
                    ],
                  ),
                ),
                buildProductTitleAndImage(context, size),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildCounterWithFavBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        Container(
          padding: EdgeInsets.all(8),
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.local_mall,
            color: Colors.white,
            size: 18,
          ),
        )
      ],
    );
  }

  Padding buildDiscription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Text(
        widget.product.description,
        textAlign: TextAlign.start,
        style: TextStyle(height: 1.0),
      ),
    );
  }

  Row buildSellerAndQuantity(BuildContext context, Size size) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Seller\n',
                    style: Theme.of(context).textTheme.subtitle1),
                TextSpan(
                  text: '${widget.product.companyName}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: size.width * 0.1),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Quantity\n',
                    style: Theme.of(context).textTheme.subtitle1),
                TextSpan(
                  text: '${widget.product.quantity}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Theme.of(context).accentColor,
      leading: IconButton(
        color: Colors.white,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Cart(),
            ),
          ),
        )
      ],
    );
  }

  buildProductTitleAndImage(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.product.productType,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            widget.product.productName,
            maxLines: 2,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 18.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'title\n'),
                    TextSpan(
                      text: '${widget.product.price}',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: size.width * 0.15),
              Expanded(
                child: SizedBox(
                  width: size.width * 0.5,
                  height: size.width * 0.5,
                  child: ListOfImages(
                    images: widget.product.productImages,
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
