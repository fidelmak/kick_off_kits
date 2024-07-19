import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/checkout.dart';
import '../screens/detail_page.dart';
import '../screens/history_detail.dart';
import '../screens/home.dart';

import '../screens/payment.dart';
import '../service/service.dart';

class ProductModel with ChangeNotifier {
  late Future<List<dynamic>> _productsFuture;
  final img = "http://api.timbu.cloud/images/";

  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _addedItems = [];
  List<Map<String, dynamic>> _cartItems = [];
  List<Map<String, dynamic>> _cartHistory = [];

  List<Map<String, dynamic>> get items => _addedItems;
  List<Map<String, dynamic>> get cartItems => _cartItems;
  List<Map<String, dynamic>> get cartHistory => _cartHistory;

  Service productsService = Service();

  String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  addToCart(Map<String, dynamic> product, context) {
    if (!_addedItems.contains(product)) {
      _cartItems.add(product);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product['name']} added to  cart'),
          duration: Duration(seconds: 2),
        ),
      );
      notifyListeners();
    }
  }

  // addToHistory(Map<String, dynamic> products, context) {
  //   if (!_addedItems.contains(product)) {
  //     _cartItems.add(products);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('${product['name']} added to  cart'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //     notifyListeners();
  //   }
  // }

  //


  Future<void> saveCartItems(List cartItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedCartItems = cartItems.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('cartItems', encodedCartItems);
  }

  //

  detailPage(context, itemId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          itemId: itemId,
        ),
      ),
    );
  }
  //////////////
  historyDetailPage(context, itemId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryDetailPage(
          itemId: itemId,
        ),
      ),
    );
  }




  ////////
  removeFromCart(Map<String, dynamic> product, context) {
    _cartItems.remove(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} removed from cart'),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += double.tryParse(item['current_price'].toString()) ?? 0.0;
    }
    return total;
  }

  checkout(context) {
    double totalPrice = getTotalPrice();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          totalPrice: totalPrice,
          productItems: _cartItems,
        ),
      ),
    );
  }

  // order history function 
 

  //  clear all items in the cart
  clearAllCart(context) {
    _cartItems.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment Successful'),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  handleCheckout(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Successfully Processed! "),
          content: Text("Click OK and proceed to confirm"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  int _counter = 0;
  get counter => _counter;
  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  void delCounter() {
    if (_counter > 0) {
      _counter = 0;
      notifyListeners();
    }
  }
}
