import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kick_off_kits/components/kits_product.dart';
import 'package:kick_off_kits/controller/controller.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final String itemId;

  const DetailPage({
    super.key,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return FutureBuilder<Map<String, dynamic>>(
        future: productModel.productsService.fetchProduct(itemId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No product available.'));
          } else {
            final product = snapshot.data!;

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
            if (product['photos'] != null && product['photos'].isNotEmpty) {
              imageUrl = productModel.img + product['photos'][0]['url'];
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text("Product Details"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      width: screenWidth / 1.2,
                      height: screenHeight / 1.2,
                      child: Column(
                        children: [
                          KitsProduct(
                            product_image: imageUrl.isNotEmpty
                                ? NetworkImage(imageUrl)
                                    as ImageProvider<Object>
                                : AssetImage('assets/images/no.jpg')
                                    as ImageProvider<Object>,
                            price_rating: Text(
                              price,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.green),
                            ),
                            myText1: Text(product['name'] ?? 'No Name'),
                            myText2: Text("Men Jersey"),
                            action: Text(""),
                          ),
                          Container(
                            width: screenWidth,
                            height: screenHeight / 14,
                            child: TextButton(
                              onPressed: () {
                                productModel.addToCart(product, context);
                                productModel.increment();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: Text(
                                "Add to Cart",
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
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    });
  }
}
