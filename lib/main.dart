import 'package:flutter/material.dart';
import 'package:kick_off_kits/screens/kit_home.dart';
import 'package:provider/provider.dart';

import 'controller/controller.dart';
import 'screens/home.dart';

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
        title: 'KickOff Kits', // title of the app
        home: KitHome(),
      ),
    );
  }
}
