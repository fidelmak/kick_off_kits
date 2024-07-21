import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/controller.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _SavedProductsPageState createState() => _SavedProductsPageState();
}

class _SavedProductsPageState extends State<OrderHistoryPage> {
  List<Map<String, dynamic>> savedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadSavedProducts();
  }

  Future<void> _loadSavedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? products = prefs.getStringList('cartItems');
    if (products != null) {
      setState(() {
        savedProducts = products
            .map((product) => jsonDecode(product) as Map<String, dynamic>)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Order History'),
          backgroundColor: Colors.white,
        ),
        body: savedProducts.isEmpty
            ? Center(
          child: Text(
            'No History.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: savedProducts.length,
          itemBuilder: (context, index) {
            final product = savedProducts[index];
            final img = "http://api.timbu.cloud/images/";

            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                title: Text(
                  product['name'] ?? 'No name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Price: ₦${product['current_price']?.toString() ?? 'No price'}',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                leading: product['photos'] != null &&
                    product['photos'].isNotEmpty
                    ? Image.network(
                  img + product['photos'][0]['url'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.grey,
                ),
                trailing: IconButton(
                  onPressed: () {
                    // Add your item ID logic here
                    var itemId = product['id'];
                    productModel.historyDetailPage(context, itemId);
                  },
                  icon: Icon(
                    Icons.handshake_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
