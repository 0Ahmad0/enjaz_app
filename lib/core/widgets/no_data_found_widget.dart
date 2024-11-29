import '/core/helpers/spacing.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({
    super.key,
    this.image = AssetsManager.noMessagesIMG,
    this.text = '',
    this.resultCount,
  });

  final String image;
  final String text;
  final int? resultCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(image!=null)
          Image.asset(
              image,
              width: 100.w,
              // height: 100.h,
              color: ColorManager.primaryColor,
              fit: BoxFit.cover,
          ),
        // SvgPicture.asset(
        //   image,
        //   width: 100.w,
        //   height: 100.h,
        //   color: ColorManager.primaryColor,
        //   fit: BoxFit.cover,
        // ),
        verticalSpace(12.h),
        Text(
          text,
          style: StyleManager.font20SemiBold(
              color: ColorManager.blackColor),
        )
      ],
    );
  }
}
