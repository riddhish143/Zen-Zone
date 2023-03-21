import 'package:final2/Screens/Dashboard.dart';
import 'package:final2/Screens/Library.dart';
import 'package:final2/Screens/Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'Explore.dart';
import 'Home.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  List<Widget> _tabs = [
    HomeScreen(),
    ExploreScreen(),
    DashboardScreen(),
    Center(
      child: Text('Upload'),
    ),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: GNav(
          curve: Curves.easeInToLinear,
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.white,
          haptic: true,
          rippleColor: Colors.black,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          tabBackgroundColor: Colors.grey.shade600,
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.explore, text: 'Explore'),
            GButton(icon: Icons.dashboard, text: 'Dashboard'),
            GButton(icon: Icons.upload, text: 'Upload'),
          ],
          gap: 8,
          onTabChange: (index)
          {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}


