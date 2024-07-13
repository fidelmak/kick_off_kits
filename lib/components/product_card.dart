import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Widget product_image;
  final Text product_text;
  final Text product_desc;

  final Widget click;

  final Text product_price;
  const ProductCard({
    Key? key,
    required this.product_image,
    required this.product_text,
    required this.product_price,
    required this.click,
    required this.product_desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      height: screenHeight,
      width: screenWidth / 1.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: product_image,
            ),
            product_text,
            product_price,
            product_desc,
            click,
          ],
        ),
      ),
    );
  }
}
