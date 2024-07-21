import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kick_off_kits/components/kits_product.dart';
import 'package:kick_off_kits/controller/controller.dart';
import 'package:kick_off_kits/majorcomponent/top_sellers.dart';
import 'package:provider/provider.dart';

class TopSellerScreen extends StatefulWidget {
  const TopSellerScreen({super.key});

  @override
  State<TopSellerScreen> createState() => _TopSellerScreenState();
}

class _TopSellerScreenState extends State<TopSellerScreen> {
  bool _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

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
            List<dynamic> topSellerProducts = snapshot.data!
                .where((product) =>
                    product['categories'] != null &&
                    product['categories']
                        .any((category) => category['name'] == 'top sellers'))
                .toList();

            if (topSellerProducts.isEmpty) {
              return Center(child: Text('No top seller products available.'));
            }

            return Container(
              height: screenHeight / 2.0, // Set the height of the ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topSellerProducts.length,
                itemBuilder: (context, index) {
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
                  if (product['photos'] != null &&
                      product['photos'].isNotEmpty) {
                    imageUrl = productModel.img + product['photos'][0]['url'];
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: screenWidth / 2,
                      child: GestureDetector(
                      onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopSellerPage(),
                            ),
                          );
                      },
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
                          myText2: Text("Men Jersey"),
                          action: Text(""), myFav:IconButton(
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: _isFavorite ? Colors.red : Colors.black,
                            size: 16,
                          ),
                          onPressed: () {
                            // setState(() {
                            //   //  productModel.addToWishList(product, context);
                            //   // _isFavorite =
                            //   // !_isFavorite; // Toggle the favorite status
                            // });
                          },
                        ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      );
    });
  }
}
