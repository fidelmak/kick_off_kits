import 'package:flutter/material.dart';
import 'package:kick_off_kits/components/first.dart';
import 'package:kick_off_kits/majorcomponent/new_arrival.dart';
import 'package:kick_off_kits/components/searv_text.dart';
import 'package:kick_off_kits/components/tab_view.dart';
import 'package:kick_off_kits/categories/new_arrivals.dart';
import 'package:kick_off_kits/categories/top_sellers.dart';
import 'package:kick_off_kits/screens/home.dart';
import 'package:provider/provider.dart';
import '../components/bottom_nav.dart';
import '../components/nav_bar.dart';
import '../controller/controller.dart';
import '../utils/colors.dart';

class KitHome extends StatefulWidget {
  @override
  State<KitHome> createState() => _KitHomeState();
}

class _KitHomeState extends State<KitHome> {
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
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: SearchText(
                        hint: "Search for anything", obscure: false)),
              ],
            ),
            const SizedBox(
              height: 24,
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
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
