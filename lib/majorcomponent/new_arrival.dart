import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kick_off_kits/components/kits_product.dart';
import 'package:kick_off_kits/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewArivalSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return FutureBuilder<List<dynamic>>(
        future: context.read<ProductModel>().productsService.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available.'));
          } else {
            // Parse the JSON data
            final categoriesJson = snapshot.data as List;
            final topSellerCategory = categoriesJson.firstWhere(
              (category) => category['name'] == 'top sellers',
              orElse: () => null,
            );

            if (topSellerCategory == null) {
              return Center(child: Text('No top sellers category available.'));
            }

            final topSellerProducts = topSellerCategory['entity_items'] as List;

            return CarouselSlider.builder(
              options: CarouselOptions(
                height: screenHeight * 0.6,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  // Optional: Add logic for when the page changes
                },
              ),
              itemCount: topSellerProducts.length,
              itemBuilder: (context, index, realIndex) {
                var product = topSellerProducts[index];

                final priceList = product['current_price'];
                String price = 'Price not available';

                if (priceList != null && priceList.isNotEmpty) {
                  final ngnPrices = priceList[0]['NGN'];
                  if (ngnPrices != null && ngnPrices.isNotEmpty) {
                    final formatter = NumberFormat('#,##0');
                    price = '₦ ${formatter.format(ngnPrices[0])}';
                  }
                }

                String imageUrl = '';
                if (product['photos'] != null && product['photos'].isNotEmpty) {
                  imageUrl = productModel.img + product['photos'][0]['url'];
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: KitsProduct(
                    product_image: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl) as ImageProvider<Object>
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
                    // myText1: Text(product['description'] ?? 'No Description'),
                    myText2: Text("Men Jersey"),
                    action: SizedBox(
                      width: 100.0,
                      height: 50.0,
                      child: TextButton(
                        onPressed: () {
                          productModel.addToCart(product);
                          productModel.increment();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ).copyWith(
                          overlayColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: Text("Add "),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      );
    });
  }
}
