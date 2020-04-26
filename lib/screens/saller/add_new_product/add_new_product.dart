import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';

class AddNewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [shadow],
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextFormField(
              decoration: inputDecoration.copyWith(
                hintText: 'Product Name..',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [shadow],
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextFormField(
              decoration: inputDecoration.copyWith(
                hintText: 'Price..',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [shadow],
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextFormField(
              decoration: inputDecoration.copyWith(
                hintText: 'Quantity..',
              ),
            ),
          ),Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [shadow],
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextFormField(
              decoration: inputDecoration.copyWith(
                hintText: 'Description..',
              ),
            ),
          ),Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [shadow],
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextFormField(
              decoration: inputDecoration.copyWith(
                hintText: 'Specifications..',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
