import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'assets_details_box_widget.dart';

class AssetsItemWidget extends StatelessWidget {
  const AssetsItemWidget({
    super.key,
    required this.image,
    required this.title,
    required this.quantity,
    required this.cost,
    required this.total,
  });

  final String image;
  final String title;
  final String quantity;
  final String cost;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: ColorManager.grayColor,
          borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 125.h,
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          verticalSpace(20.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: StyleManager.font14Bold(),
          ),
          verticalSpace(20.h),
          Row(
            children: [
              AssetDetailsBoxWidget(
                title: StringManager.quantityText,
                subtitle: quantity,
              ),
              horizontalSpace(10.w),
              AssetDetailsBoxWidget(
                title: StringManager.costText,
                subtitle: cost,
              ),
              horizontalSpace(10.w),
              AssetDetailsBoxWidget(
                title: StringManager.totalText,
                subtitle: total,
              ),
            ],
          )
        ],
      ),
    );
  }
}
