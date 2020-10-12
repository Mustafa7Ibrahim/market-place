// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:market_place/constant/toast.dart';
// import 'package:market_place/screens/cart/cart.dart';
// import 'package:market_place/screens/my_account/my_account.dart';

// class CustomAppBar extends PreferredSize {
//   final double height;
//   final bool home;

//   CustomAppBar(this.height, this.home);
//   @override
//   Size get preferredSize => Size.fromHeight(height);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         AppBar(
//           leading: home
//               ? Icon(Icons.shopping_bag_outlined)
//               : IconButton(
//                   icon: Icon(Icons.arrow_back_ios_rounded),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//           title: Text('M-Place'),
//           titleSpacing: 0.0,
//           actions: [
//             IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
//             IconButton(
//               icon: Icon(Icons.shopping_cart_outlined),
//               onPressed: () => Navigator.push(
//                 context,
//                 CupertinoPageRoute(builder: (context) => Cart()),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.dehaze_rounded),
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   backgroundColor: Colors.transparent,
//                   barrierColor: Colors.black.withOpacity(0.8),
//                   elevation: 0.9,
//                   isScrollControlled: true,
//                   clipBehavior: Clip.antiAlias,
//                   enableDrag: true,
//                   isDismissible: true,
//                   builder: (context) {
//                     return Container(
//                       margin: EdgeInsets.all(24.0),
//                       child: MyAccount(),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//         Divider(height: 2, thickness: 0.3, color: Colors.grey.withOpacity(0.5)),
//       ],
//     );
//   }
// }
