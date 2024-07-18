import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedProductsPage extends StatefulWidget {
  @override
  _SavedProductsPageState createState() => _SavedProductsPageState();
}

class _SavedProductsPageState extends State<SavedProductsPage> {
  List<String> savedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadSavedProducts();
  }

  Future<void> _loadSavedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? products = prefs.getStringList('savedProducts');
    if (products != null) {
      setState(() {
        savedProducts = products;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
        backgroundColor: Colors.black,
      ),
      body: savedProducts.isEmpty
          ? Center(
              child: Text(
                'No Purchase.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: savedProducts.length,
              itemBuilder: (context, index) {
                final product = savedProducts[index];
                // Assuming the product string is a JSON string
                final productMap = product.toString();

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      productMap, // Adjust based on the actual structure of the product string
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      Icons.shopping_bag,
                      color: Colors.deepPurple,
                      size: 40,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.deepPurple,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
