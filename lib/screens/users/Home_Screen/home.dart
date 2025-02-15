import 'package:flutter/material.dart';
import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/users/Cart_Screen/cart_screen.dart';
import 'package:drawer/screens/users/Category_Screen.dart/category_screen.dart';
import 'package:drawer/screens/users/Home_Screen/home_screen.dart';
import 'package:drawer/screens/users/profile_Screen/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentNavIndex = 0;

  var navListItem = [
    BottomNavigationBarItem(icon: Image.asset(icHome, width: 25), label: 'Home'),
    BottomNavigationBarItem(icon: Image.asset(icCategories, width: 25), label: 'Category'),
    BottomNavigationBarItem(icon: Image.asset(icCart, width: 25), label: 'Cart'),
    BottomNavigationBarItem(icon: Image.asset(icProfile, width: 25), label: 'Profile'),
  ];

  var navBody = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentNavIndex != 0) {
          setState(() {
            currentNavIndex = 0;  // Navigate back to Home screen when back button is pressed
          });
          return false;  // Prevent default back behavior
        }
        return true;  // Allow exiting the app when on the Home screen
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: navBody.elementAt(currentNavIndex)),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentNavIndex,
          items: navListItem,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          onTap: (value) {
            setState(() {
              currentNavIndex = value;
            });
          },
        ),
      ),
    );
  }
}
