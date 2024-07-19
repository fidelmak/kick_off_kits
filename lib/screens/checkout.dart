import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controller/controller.dart';
import 'payment.dart';

class CheckoutPage extends StatelessWidget {
  final double totalPrice;
  final List productItems;

  const CheckoutPage(
      {super.key, required this.totalPrice, required this.productItems});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(
      builder: (context, productModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Checkout'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: screenHeight / 4,
                    width: screenWidth / 1.2,
                    child: Image.asset(
                      "assets/images/mpay.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 40),




                Text(
                  'Price to Check-Out:\n NGN ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Container(
                  width: screenWidth / 1.5,
                  height: screenHeight / 12,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      productModel.handleCheckout(context);
                    },
                    child: Text(
                      "Make Payment",
                      style: TextStyle(color: Colors.white, fontSize: 18),
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
