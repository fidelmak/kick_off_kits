import 'package:flutter/material.dart';
import 'package:kick_off_kits/components/first.dart';
import 'package:kick_off_kits/components/majorcomponent/new_arrival.dart';
import 'package:kick_off_kits/components/searv_text.dart';
import 'package:kick_off_kits/components/tab_view.dart';
import 'package:kick_off_kits/screens/categories/new_arrivals.dart';
import 'package:kick_off_kits/screens/categories/top_sellers.dart';
import 'package:kick_off_kits/screens/home.dart';
import 'package:provider/provider.dart';
import '../components/bottom_nav.dart';
import '../components/nav_bar.dart';
import '../controller/controller.dart';
import '../utils/colors.dart';

class KitHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      bottomNavigationBar: BottomNav(),
      backgroundColor: textWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: ProfileNav(screenWidth: screenWidth),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: SearchText(
                          hint: "Search for anything", obscure: false)),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.green,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        print('Star button pressed');
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FirstScreen(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Sellers"),
                  TextButton(onPressed: () {}, child: Text("More")),
                ],
              ),
            ),
            NewListScreen(),
            const SizedBox(
              height: 10,
            ),
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
