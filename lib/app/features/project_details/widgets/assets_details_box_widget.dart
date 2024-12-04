import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/style_manager.dart';

class AssetDetailsBoxWidget extends StatelessWidget {
  const AssetDetailsBoxWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: StyleManager.font14Bold(),
        ),
        verticalSpace(10.h),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: StyleManager.font12SemiBold(
            color: ColorManager.hintTextColor,
          ),
        )
      ],
    ));
  }
}
