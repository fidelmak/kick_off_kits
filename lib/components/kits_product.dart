import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kick_off_kits/controller/controller.dart';

class KitsProduct extends StatelessWidget {
  final ImageProvider product_image;
  final Widget price_rating;
  final Widget action;
  final Widget myText2;
  final Widget myText1;
  final Widget myFav;

   KitsProduct({
    super.key,
    required this.product_image,
    required this.myFav,
    required this.action,
    required this.price_rating,
    required this.myText2,
    required this.myText1,
  });



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Column(
        children: [
          Container(
            width: screenWidth / 1.5,
            height: screenHeight / 4.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: product_image,
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                        ),
                        child: myFav
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black,
                            size: 16,
                          ),
                          onPressed: () {},
                          color: Colors.green,
                          hoverColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight / 7,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: price_rating),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.star, color: Colors.yellow),
                          onPressed: () {
                            print('Star button pressed');
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: myText1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: myText2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          action,
        ],
      );
    });
  }
}
