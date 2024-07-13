import 'package:flutter/material.dart';

class CategoryFeatures extends StatelessWidget {
  final Text categoryText1;

  final Function categoryFunction1;

  const CategoryFeatures({
    Key? key,
    required this.categoryText1,
    required this.categoryFunction1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: categoryFunction1(), child: categoryText1),
      ],
    );
  }
}
