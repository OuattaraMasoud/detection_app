import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SideMenu extends StatelessWidget {
  final int currentIndex;
  final Function(int) onMenuItemSelected;

  const SideMenu({
    Key? key,
    required this.currentIndex,
    required this.onMenuItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Detection App',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            isSelected: currentIndex == 0,
            press: () => onMenuItemSelected(0),
          ),
          DrawerListTile(
            title: "Détection",
            svgSrc: "assets/icons/menu_tran.svg",
            isSelected: currentIndex == 1,
            press: () => onMenuItemSelected(1),
          ),
          DrawerListTile(
            title: "Profil",
            svgSrc: "assets/icons/menu_profile.svg",
            isSelected: currentIndex == 2,
            press: () => onMenuItemSelected(2),
          ),
          DrawerListTile(
            title: "Parametres",
            svgSrc: "assets/icons/menu_setting.svg",
            isSelected: currentIndex == 3,
            press: () => onMenuItemSelected(3),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, svgSrc;
  final bool isSelected;
  final VoidCallback press;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.isSelected,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      child: ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(
          svgSrc,
          color: isSelected ? primaryColor : Colors.grey.shade900,
          height: 16,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: isSelected ? primaryColor : Colors.grey.shade900),
        ),
        selected: isSelected,
        selectedTileColor: Colors.blue.withOpacity(0.1),
      ),
    );
  }
}
