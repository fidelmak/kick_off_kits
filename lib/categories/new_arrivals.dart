import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kick_off_kits/components/kits_product.dart';
import 'package:kick_off_kits/controller/controller.dart';
import 'package:kick_off_kits/majorcomponent/new_arrival.dart';
import 'package:provider/provider.dart';

class NewListScreen extends StatefulWidget {
  const NewListScreen({super.key});


  @override
  State<NewListScreen> createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
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
            return Center(child: Text("..."));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No internet available.'));
          } else {
            List<dynamic> newArrivalProducts = snapshot.data!
                .where((product) =>
                    product['categories'] != null &&
                    product['categories']
                        .any((category) => category['name'] == 'new'))
                .toList();

            if (newArrivalProducts.isEmpty) {
              return Center(child: Text('No new arrival products available.'));
            }

            return Container(
              height: screenHeight / 2, // Set the height of the ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newArrivalProducts.length,
                itemBuilder: (context, index) {
                  var product = newArrivalProducts[index];

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
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      width: screenWidth / 2,
                      height: screenHeight / 3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewArrivalPage(),
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
                          action: Text(""), myFav: IconButton(
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: _isFavorite ? Colors.red : Colors.black,
                            size: 16,
                          ),
                          onPressed: () {
                            // setState(() {
                            //   // productModel.addToWishList(product, context);
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
