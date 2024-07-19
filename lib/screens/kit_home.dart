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
import '../majorcomponent/top_sellers.dart';
import '../utils/colors.dart';

class KitHome extends StatefulWidget {
  const KitHome({super.key});

  @override
  State<KitHome> createState() => _KitHomeState();
}

class _KitHomeState extends State<KitHome> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Scaffold(
        bottomNavigationBar: const BottomNav(),
        backgroundColor: textWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SearchText(
                          hint: "Search for anything",
                          obscure: false,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(0.0),
                            child: IconButton(
                              icon: Icon(Icons.shopping_cart,
                                  size: 24, color: Colors.black),
                              onPressed: () {},
                            ),
                          ),
                          Text(
                            '${productModel.counter}',
                            style: TextStyle(fontSize: 14, color: primaryRed),
                          ),
                          SizedBox(
                            width: 2,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const FirstScreen(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Sellers",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopSellerPage(),
                            ),
                          );
                        },
                        child: const Text("More"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TopSellerScreen(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("New Sellers", style: TextStyle(fontSize: 18)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewArrivalPage(),
                            ),
                          );
                        },
                        child: const Text("More"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: NewListScreen(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("More of what you like",
                          style: TextStyle(fontSize: 18)),
                      TextButton(
                        onPressed: () {},
                        child: const Text("More"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: HomeScreen(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
