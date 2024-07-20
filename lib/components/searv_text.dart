import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../screens/search_field.dart';
 // Replace with the actual import for your ProductDetailsPage

class SearchText extends StatefulWidget {
  final String hint;
  final bool obscure;

  const SearchText({
    super.key,
    required this.hint,
    required this.obscure,
  });

  @override
  _SearchTextState createState() => _SearchTextState();
}

class _SearchTextState extends State<SearchText> {
  final TextEditingController _controller = TextEditingController();

  void _searchProduct(BuildContext context) async {
    String name = _controller.text;
    if (name.isNotEmpty) {
      var products = await context.read<ProductModel>().productsService.fetchSearchProduct(name);

      if (products is List) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchFieldPage(products: products),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No products found or invalid response.')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        height: 50,
        width: screenWidth,
        child: TextField(
          controller: _controller,
          obscureText: widget.obscure,
          style: TextStyle(fontSize: 24, color: Colors.black), // Text color set to black
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.black, // Search icon color set to black
              ),
              onPressed: () => _searchProduct(context),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black), // Border color set to black
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black), // Border color set to black
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black, // Border color set to black
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
