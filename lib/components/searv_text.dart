import 'package:flutter/material.dart';


class SearchText extends StatelessWidget {
  final String hint;
  final bool obscure;

  const SearchText({
    super.key,
    required this.hint,
    required this.obscure,
  });

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
          obscureText: obscure,
          style: TextStyle(
              fontSize: 24, color: Colors.black), // Text color set to black
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.black, // Search icon color set to black
              ),
              onPressed: () {},
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black), // Border color set to black
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black), // Border color set to black
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
