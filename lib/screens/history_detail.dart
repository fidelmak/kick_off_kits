import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kick_off_kits/components/kits_product.dart';
import 'package:kick_off_kits/controller/controller.dart';
import 'package:provider/provider.dart';

class HistoryDetailPage extends StatefulWidget {
  final String itemId;

  const HistoryDetailPage({
    super.key,
    required this.itemId,
  });

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  bool _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return FutureBuilder<Map<String, dynamic>>(
        future: productModel.productsService.fetchProduct(widget.itemId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No history .'));
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
                title: const Text("product His. Details"),
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
                            action: Text(""), myFav:IconButton(
                            icon: Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline_outlined,
                              color: _isFavorite ? Colors.red : Colors.black,
                              size: 16,
                            ),
                            onPressed: () {
                              setState(() {
                                // productModel.addToWishList(product, context);
                                // _isFavorite =
                                // !_isFavorite; // Toggle the favorite status
                              });
                            },
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
