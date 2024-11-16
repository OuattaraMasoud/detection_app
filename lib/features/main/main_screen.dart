import 'package:detectionApp/constants.dart';
import 'package:detectionApp/controllers/menu_app_controller.dart';
import 'package:detectionApp/features/detection/views/init_detection_page.dart';
import 'package:detectionApp/features/profile/views/profile_page.dart';
import 'package:detectionApp/features/settings/views/views.dart';
import 'package:detectionApp/responsive.dart';
import 'package:detectionApp/features/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    InitDetectionPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(
        onMenuItemSelected: _onMenuItemSelected,
        currentIndex: _currentIndex,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show side menu on large screens
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(
                  onMenuItemSelected: _onMenuItemSelected,
                  currentIndex: _currentIndex,
                ),
              ),
            Expanded(
              flex: 5,
              child: _pages[_currentIndex],
            ),
          ],
        ),
      ),
      // Show BottomNavigationBar only on mobile
      bottomNavigationBar: !Responsive.isDesktop(context)
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onBottomNavTapped,
              selectedItemColor: primaryColor,
              unselectedItemColor: Colors.grey.shade800,
              unselectedIconTheme: IconThemeData(color: Colors.grey.shade800),
              selectedIconTheme: IconThemeData(color: primaryColor),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.document_scanner_outlined),
                  label: 'Détection',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Paramètres',
                ),
              ],
            )
          : null,
    );
  }

  void _onMenuItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (!Responsive.isDesktop(context)) {
      Navigator.of(context).pop(); // Close the drawer if on mobile
    }
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
