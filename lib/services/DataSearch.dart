// import 'package:flutter/material.dart';
// import 'package:market_place/constant/constant.dart';

// class DataSearch extends SearchDelegate<String> {
//   var _products;

//   Future getData() async {
//     final path = productCollection.document();
//     _products = await path.get();
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {},
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {},
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {}

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     getData();
//     final suggestionList = query.isEmpty ? null : _products.data['productName'];
//     return ListView.builder(
//       itemCount: suggestionList?.length ?? 0,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(_products.data['productName']),
//           subtitle: Text(_products.data['productType']),
//         );
//       },
//     );
//   }
// }
