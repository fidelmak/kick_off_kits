import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Container(
      child: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/hero.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          color: Colors.white.withOpacity(0.3),
                          child: Text(
                            "2024/2025 JERSEY ARRIVAL",
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 4.0,
                                    color: Colors.green,
                                  ),
                                ],
                                color: Colors.green,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   width: screenWidth,
          //   height: screenHeight / 2,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/hero.png'),
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),
          // Container(
          //   color: Colors.white,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Container(
          //             child: Text(
          //           "2024/2025 ",
          //           style: TextStyle(
          //               color: Colors.black,
          //               fontSize: 24,
          //               fontWeight: FontWeight.bold),
          //         )),
          //         SizedBox(
          //           height: 2,
          //         ),
          //         Container(
          //             width: screenWidth,
          //             child: Center(
          //               child: Text(
          //                 "JERSEY",
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 56,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             )),
          //         SizedBox(
          //           height: 8,
          //         ),
          //         Container(
          //             child: Center(
          //           child: Text(
          //             "Your destination for top-quality football jerseys.Designed for players and fans alike, our jerseys combine performance, comfort, and style. Show your team spirit and elevate your game with Kickoff Kits!",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.normal),
          //           ),
          //         )),
          //         SizedBox(
          //           height: 14,
          //         ),
          //         Container(
          //           width: screenWidth,
          //           height: screenHeight / 14,
          //           child: TextButton(
          //             onPressed: () {},
          //             style: TextButton.styleFrom(
          //               backgroundColor: Colors.black,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius
          //                     .zero, // Rectangle shape without any curves
          //               ),
          //             ),
          //             child: Text(
          //               "Shop Now",
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
