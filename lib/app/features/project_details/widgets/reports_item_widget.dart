import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'assets_details_box_widget.dart';

class ReportsItemWidget extends StatelessWidget {
  const ReportsItemWidget({
    super.key,
    required this.image,
    required this.name,
    required this.date,
  });

  final String image;
  final String name;
  final String date;

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
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8.r)
              ),
              child: Image.asset(
                'assets/images/pdf.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(image),
            ),
            title: Text(
              name,
              style: StyleManager.font14Bold(),
            ),
            subtitle: Text(
              date,
              style: StyleManager.font12SemiBold(
                  color: ColorManager.hintTextColor),
            ),
            trailing: InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  AssetsManager.fileDownloadIcon,
                  width: 30.w,
                  height: 30.h,
                )),
          ),
        ],
      ),
    );
  }
}
