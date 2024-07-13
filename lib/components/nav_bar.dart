import 'package:flutter/material.dart';
import 'package:kick_off_kits/controller/controller.dart';

import 'package:provider/provider.dart';

import '../utils/colors.dart';

class ProfileNav extends StatefulWidget {
  const ProfileNav({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<ProfileNav> createState() => _ProfileNavState();
}

class _ProfileNavState extends State<ProfileNav> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${productModel.counter}',
                style: TextStyle(fontSize: 14, color: primaryRed),
              ),
            ],
          ),
          actions: [],
        ),
      );
    });
  }
}
