import 'package:flutter/material.dart';

import 'category.dart';
import 'product_card.dart';

class Products extends StatelessWidget {
  final CategoryFeatures features;
  final ProductCard card1;

  const Products({
    Key? key,
    required this.features,
    required this.card1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, //.withOpacity(0.09),
      child: Column(
        children: [
          Center(child: card1),
          features,
        ],
      ),
    );
  }
}
