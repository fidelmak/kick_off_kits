import 'package:flutter/material.dart';
import 'package:kick_off_kits/controller/controller.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const Text("ORDER SUMMARY"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text("Items"),
                Text('${productModel.counter}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text("Delivery"),
                Text('FREE'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text("Service"),
                Text('FREE'),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text("Do you have a coupon Code?"),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          height: screenHeight / 14,
                          width: screenWidth / 1.7,
                          child: TextField(
                            obscureText: false,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black), // Text color set to black
                            decoration: InputDecoration(
                              hintText: "Enter your Coupon Code ",
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .black), // Border color set to black
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey), // Border color set to black
                                borderRadius: BorderRadius.circular(1),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color:
                                      Colors.grey, // Border color set to black
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Apply",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children:  [
                    Text("Subtotal"),
                    Text('${productModel.getTotalPrice()}'),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: screenWidth / 2,
                      height: screenHeight / 14,
                      child: TextButton(
                        onPressed: () {
                          productModel.checkout(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          side: const BorderSide(color: Colors.green),
                        ),
                        child: const Text(
                          "Proceed to CheckOut",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
