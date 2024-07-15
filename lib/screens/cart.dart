import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            title: Text("Check-out Products"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Expanded(
                  child: productModel.cartItems.isNotEmpty
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: productModel.cartItems.length,
                          itemBuilder: (context, index) {
                            var product = productModel.cartItems[index];
                            final priceList = product['current_price'];
                            String price = 'Price not available';
                            if (priceList != null && priceList.isNotEmpty) {
                              final ngnPrices = priceList[0]['NGN'];
                              if (ngnPrices != null && ngnPrices.isNotEmpty) {
                                price = 'NGN ${ngnPrices[0].toString()}';
                              }
                            }

                            return GridTile(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        img + product['photos'][0]['url'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      product['name'] ?? 'No Name',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 4),
                                    Text(price),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Remove"),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                            ),
                                            onPressed: () {
                                              productModel.removeFromCart(
                                                  product, context);
                                              productModel.decrement();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text("No items in the cart"),
                        ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(20),
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
                    child: Text(
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
