import 'package:flutter/material.dart';
import 'package:kick_off_kits/screens/kit_home.dart';
import 'package:provider/provider.dart';

import 'controller/controller.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KickOff Kits', 
        home: SplashScreen(),
      ),
    );
  }
}
