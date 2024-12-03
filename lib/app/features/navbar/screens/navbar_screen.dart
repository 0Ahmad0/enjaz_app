import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/const_value_manager.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
   int _currentIndex = 0;

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
        currentIndex: _currentIndex,
        onTap:  _onTap,
        fixedColor: ColorManager.primaryColor,
        elevation: 0.0,
        unselectedItemColor: ColorManager.unselectedItemColor,
        type: BottomNavigationBarType.shifting,
        items: ConstValueManager.navBarList
            .map(
              (e) => BottomNavigationBarItem(
                icon: SvgPicture.asset(e.icon,
                width: 30.sp,
                  height: 30.sp,
                ),
                label: e.label,
                tooltip: e.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
