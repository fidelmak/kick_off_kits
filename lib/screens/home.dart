import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/bottom_nav.dart';
import '../components/category.dart';
import '../components/kits_product.dart';
import '../components/nav_bar.dart';
import '../components/product_card.dart';
import '../components/products.dart';
import '../controller/controller.dart';
import '../utils/colors.dart';
import '../service/service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Scaffold(
        bottomNavigationBar: BottomNav(),
        backgroundColor: textGrey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: ProfileNav(screenWidth: screenWidth),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: context.read<ProductModel>().productsService.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products available.'));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7, // Adjust as needed
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

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: KitsProduct(
                      product_image: imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl) as ImageProvider<Object>
                          : AssetImage('assets/no.jpg')
                              as ImageProvider<Object>,
                      price_rating: Text(
                        price,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.green),
                      ),
                      myText2: Text("Men Jersey"),
                      action: () {
                        productModel.addToCart(product, context);
                        productModel.increment();
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    });
  }
}
