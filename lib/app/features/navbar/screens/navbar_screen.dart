import 'package:flutter/material.dart';

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
