import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uber_web_admin_panel/views/dashboard_screens/dashboard_screens.dart';
import 'package:uber_web_admin_panel/views/screens/buyers_screen.dart';
import 'package:uber_web_admin_panel/views/screens/category_screen.dart';
import 'package:uber_web_admin_panel/views/screens/order_screen.dart';
import 'package:uber_web_admin_panel/views/screens/product_screen.dart';
import 'package:uber_web_admin_panel/views/screens/upload_banner_screen.dart';
import 'package:uber_web_admin_panel/views/screens/vendors_screen.dart';
import 'package:uber_web_admin_panel/views/screens/withdrawal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              apiKey: "AIzaSyDu7e7IDZpF6HU63Sd4VLzjz3CSoL08AKE",
              appId: "1:638944811878:web:8fa5ab507c468fcd49c6a7",
              messagingSenderId: "638944811878",
              projectId: "uber-app-d8d96",
              storageBucket: "uber-app-d8d96.appspot.com",
            )
          : null);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Web Pannel',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: SideMenu(),
      builder: EasyLoading.init(),
    );
  }
}

class SideMenu extends StatefulWidget {
  static const String id = '\sideMenu';

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Widget _selectedScreen = DashboardScreen();

  screnSelectore(item) {
    switch (item.route) {
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });

        break;
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = VendorsScreen();
        });

        break;

      case BuyersScreen.id:
        setState(() {
          _selectedScreen = BuyersScreen();
        });

        break;

      case WithrawalScreen.id:
        setState(() {
          _selectedScreen = WithrawalScreen();
        });

        break;

      case OrderScreen.routeName:
        setState(() {
          _selectedScreen = OrderScreen();
        });

        break;

      case UploadBanners.id:
        setState(() {
          _selectedScreen = UploadBanners();
        });

        break;

      case ProductScreen.routeName:
        setState(() {
          _selectedScreen = ProductScreen();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: const Text(
          'Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.id,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: BuyersScreen.id,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            route: WithrawalScreen.id,
            icon: CupertinoIcons.money_dollar,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrderScreen.routeName,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category_rounded,
            route: CategoryScreen.id,
          ),
          AdminMenuItem(
            title: 'Upload Banner',
            icon: CupertinoIcons.add,
            route: UploadBanners.id,
          ),
          AdminMenuItem(
            title: 'Products',
            icon: CupertinoIcons.shopping_cart,
            route: ProductScreen.routeName,
          ),
        ],
        selectedRoute: VendorsScreen.id,
        onSelected: (item) {
          screnSelectore(item);

          // if (item.route != null) {
          //   Navigator.of(context).pushNamed(item.route!);
          // }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.yellow.shade700,
          child: const Center(
            child: Text(
              'Multi Store Admin ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedScreen,
    );
  }
}
