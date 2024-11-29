import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPaddingWidget extends StatelessWidget {
  const AppPaddingWidget({
    super.key,
    required this.child,
    this.horizontalPadding = 20,
    this.verticalPadding = 12,
  });

  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding.w,
        vertical: verticalPadding.h,
      ),
      child: child,
    );
  }
}
