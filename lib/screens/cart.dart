import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/controller.dart';

class CartView extends StatelessWidget {
  final List cartItems;

  CartView({required this.cartItems});

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
            title: const Text("Check-out Products"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Expanded(
                  child: productModel.cartItems.isNotEmpty
                      ? ListView.builder(
                          itemCount: productModel.cartItems.length,
                          itemBuilder: (context, index) {
                            var product = productModel.cartItems[index];
                            final priceList = product['current_price'];
                            String price = 'Price not available';

                            if (priceList != null && priceList.isNotEmpty) {
                              final ngnPrices = priceList[0]['NGN'];
                              if (ngnPrices != null && ngnPrices.isNotEmpty) {
                                final formatter = NumberFormat('#,##0');
                                price = '₦ ${formatter.format(ngnPrices[0])}';
                              }
                            }

                            return Container(
                              height: screenHeight / 4,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                child: Row(
                                  children: [
                                    Column(
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
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              SizedBox(width: 70),
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
                                              SizedBox(width: 80),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                ),
                                                onPressed: () {
                                                  productModel.removeFromCart(
                                                      product, context);
                                                  productModel.decrement();
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text("No items in the cart"),
                        ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: screenWidth / 1.5,
                  height: screenHeight / 12,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      productModel.checkout(context);
                    },
                    child: const Text(
                      "CheckOut",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
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
