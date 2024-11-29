import '/core/utils/color_manager.dart';
import '/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color = ColorManager.primaryColor});

  final VoidCallback onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: StyleManager.font16Regular(color: ColorManager.whiteColor),
        ));
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color = ColorManager.primaryColor});

  final VoidCallback onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ElevatedButton.styleFrom(side: BorderSide(color: color)),
        onPressed: onPressed,
        child: Text(
          text,
          style: StyleManager.font16Regular(color: color),
        ));
  }
}
