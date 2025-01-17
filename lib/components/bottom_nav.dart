import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../screens/cart.dart';

import '../controller/controller.dart';
import '../screens/kit_home.dart';
import '../screens/order_history.dart';
import '../screens/wish_list_page.dart';

// bottom nav bar
class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white, // custom color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              KitHome(), // navigating to the home screen
                        ),
                      );
                    },
                    icon: Icon(Icons.home),
                  ),
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            // button icons with text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartView(cartItems: productModel.cartItems),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                  Text(
                    'Cart',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WishListPage(wishListItems: productModel.wishLists,)
                        ),
                      );
                    },
                    icon: Icon(Icons.favorite_outline),
                  ),
                  Text(
                    'WishList',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderHistoryPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.history),
                  ),
                  Text(
                    'History',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
