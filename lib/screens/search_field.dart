import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/kits_product.dart';
import '../controller/controller.dart';

class SearchFieldPage extends StatefulWidget {
  final List<dynamic> products;

  const SearchFieldPage({Key? key, required this.products}) : super(key: key);

  @override
  State<SearchFieldPage> createState() => _SearchFieldPageState();
}

class _SearchFieldPageState extends State<SearchFieldPage> {
  bool _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (context, productModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search Details'),
          ),
          body: widget.products.isEmpty
              ? const Center(
            child: Text(
              'No products found.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
              : ListView.builder(
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              var product = widget.products[index];

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
                        : AssetImage('assets/images/no.jpg') as ImageProvider<Object>,
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
                    action: const SizedBox(height: 1), myFav: IconButton(
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
                      //   _isFavorite =
                      //   !_isFavorite; // Toggle the favorite status
                      // });
                    },
                  ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
