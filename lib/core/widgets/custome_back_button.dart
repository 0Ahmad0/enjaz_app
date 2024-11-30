import '/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_manager.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        if(Navigator.canPop(context)){
          context.pop();
        }
      },
      icon: Icon(Icons.arrow_back_ios_new),
    );
  }
}
