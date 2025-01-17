import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/kits_product.dart';
import '../controller/controller.dart';
import '../service/service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create a PageStorageBucket
  final PageStorageBucket bucket = PageStorageBucket();
  bool _isFavorite = false;

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
            return Center(child: Text("..."));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Internet available.'));
          } else {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  key: PageStorageKey(
                      'gridview'), // Assign a PageStorageKey to the GridView
                  physics:
                      NeverScrollableScrollPhysics(), // Prevents GridView from scrolling
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.5, // Adjust as needed
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var product = snapshot.data![index];

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

                    String itemId = product["id"];
                    

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          productModel.detailPage(context, itemId);
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
                          action: SizedBox(
                            height: 1,
                          ), myFav: IconButton(
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: _isFavorite ? Colors.red : Colors.black,
                            size: 16,
                          ),
                          onPressed: () {

                          },
                        ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      );
    });
  }
}
