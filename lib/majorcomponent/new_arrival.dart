import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kick_off_kits/components/nav_bar.dart';
import 'package:provider/provider.dart';
import '../components/bottom_nav.dart';
import '../components/kits_product.dart';
import '../controller/controller.dart';
import '../service/service.dart';
import '../utils/colors.dart';

class NewArrivalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      backgroundColor: textWhite,
      appBar: AppBar(
        backgroundColor: textWhite,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("New Arrivals"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: NewArrival(),
            ),
          ],
        ),
      ),
    );
  }
}

class NewArrival extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (context, productModel, child) {
        return FutureBuilder<List<dynamic>>(
          future: productModel.productsService.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading..."));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available.'));
            } else {
              List<dynamic> newArrivalProducts = snapshot.data!
                  .where((product) =>
                      product['categories'] != null &&
                      product['categories']
                          .any((category) => category['name'] == 'new'))
                  .toList();

              if (newArrivalProducts.isEmpty) {
                return const Center(
                    child: Text('No new arrival products available.'));
              }

              return GridView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Prevents GridView from scrolling
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.5, // Adjust as needed
                ),
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
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () {
                        productModel.addToCart(product, context);
                      },
                      child: KitsProduct(
                        product_image: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl) as ImageProvider<Object>
                            : AssetImage('assets/images/no.jpg')
                                as ImageProvider<Object>,
                        price_rating: Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.green,
                          ),
                        ),
                        myText1: Text(product['name'] ?? 'No Name'),
                        myText2: const Text("Men Jersey"),
                        action: const SizedBox(height: 1),
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
