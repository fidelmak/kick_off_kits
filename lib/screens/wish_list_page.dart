import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kick_off_kits/components/order_summary.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/controller.dart';

class WishListPage extends StatelessWidget {
  final List<Map<String, dynamic>> wishListItems;

  WishListPage({required this.wishListItems});

  final img = "http://api.timbu.cloud/images/";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(
      builder: (context, productModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Wish-lists"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Expanded(
                  child: productModel.wishLists.isNotEmpty
                      ? ListView.builder(
                    itemCount: productModel.wishLists.length,
                    itemBuilder: (context, index) {
                      var product = productModel.wishLists[index];


                      final priceList = product['current_price'];
                      String price = 'Price not available';

                      if (priceList != null) {
                        final ngnPrices = priceList;
                        if (ngnPrices != null) {
                          final formatter = NumberFormat('#,##0');
                          price = '₦ ${formatter.format(ngnPrices)}';
                        }
                      }

                      String imageUrl = '';
                      if (product['photos'] != null &&
                          product['photos'].isNotEmpty) {
                        imageUrl = productModel.img + product['photos'][0]['url'];
                      }


                      return Container(
                        height: screenHeight / 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth / 3,
                              height: screenHeight / 5,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  img + product['photos'][0]['url'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'] ?? 'No Name',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      price,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("M"),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              ),
                                              onPressed: () {},
                                            ),
                                            Text("1"),
                                            IconButton(
                                              icon: Icon(
                                                Icons.add_circle,
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Text("Remove"),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red
                                                .withOpacity(0.5),
                                          ),
                                          onPressed: () {
                                            productModel.removeFromWishList(
                                                product, context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                      : const Center(
                    child: Text("No wishlist, you have to purchase 50 items "),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
