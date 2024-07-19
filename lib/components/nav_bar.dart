import 'package:flutter/material.dart';
import 'package:kick_off_kits/controller/controller.dart';
import 'package:provider/provider.dart';
import '../screens/order_history.dart';
import '../utils/colors.dart';

class ProfileNav extends StatefulWidget {
  const ProfileNav({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<ProfileNav> createState() => _ProfileNavState();
}

class _ProfileNavState extends State<ProfileNav> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (context, productModel, child) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent.withOpacity(0.2),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center ,
                children: [



                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            size: 24,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        '${productModel.counter}',
                        style: TextStyle(fontSize: 14, color: primaryRed),
                      ),
                    ],
                  ),
                  Center(
                    child:ClipOval(
                  child:Text(
                    'KKit '.toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                 ) 
                  )
                 ,

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderHistoryPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.history, size:24),
                  ),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
