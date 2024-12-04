import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/const_value_manager.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
   int _currentIndex = 2;

  _onTap(index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstValueManager.navBarList[_currentIndex].route,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorManager.whiteColor,
        currentIndex: _currentIndex,
        onTap:  _onTap,
        fixedColor: ColorManager.primaryColor,
        elevation: 0.0,
        unselectedItemColor: ColorManager.unselectedItemColor,
        // type: BottomNavigationBarType.shifting,
        selectedLabelStyle: StyleManager.font12Regular(),
        items: ConstValueManager.navBarList
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.label,
                tooltip: e.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
