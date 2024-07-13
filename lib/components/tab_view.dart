import 'package:flutter/material.dart';
import 'package:kick_off_kits/screens/home.dart';

class TabMenuBar extends StatefulWidget {
  const TabMenuBar({super.key});

  @override
  _TabMenuBarState createState() => _TabMenuBarState();
}

class _TabMenuBarState extends State<TabMenuBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: screenWidth,
              height: screenHeight / 15,
              decoration: BoxDecoration(
                color: Colors.grey.shade300, // Background color for the TabBar
                borderRadius: BorderRadius.circular(5), // Radius of 10
              ), // Background color for the TabBar
              child: TabBar(
                controller: _tabController,
                onTap: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                indicator: BoxDecoration(
                  color: Colors.white, // Background color for the active tab
                ),
                indicatorSize:
                    TabBarIndicatorSize.tab, // Use full tab width for indicator
                indicatorPadding: EdgeInsets.symmetric(
                  horizontal: (screenWidth - 100 * 3) / 6,
                ), // Adjust padding to center the fixed width indicator
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'New Arrival'),
                  Tab(text: 'Top Sellers'),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
              children: [
                HomeScreen(),
                Screen2(),
                Screen3(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Screen 1'));
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Screen 2'));
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Screen 3'));
  }
}
