import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressProjectItemWidget extends StatelessWidget {
  const ProgressProjectItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.grayColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 36.sp,
            lineWidth: 5,
            percent: .32,
            center: Text(
              "32",
              style: StyleManager.font24Bold(),
            ),
            progressColor: ColorManager.primaryColor,
            backgroundColor: ColorManager.whiteColor,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          horizontalSpace(10.w),
          Flexible(
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  isThreeLine: true,
                  contentPadding: EdgeInsets.zero,
                  trailing: Icon(
                    Icons.table_chart,
                  ),
                  title: Text(
                    'VIP House Building',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font14Bold(),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 16.sp,
                      ),
                      horizontalSpace(4.w),
                      Text(
                        'KSA , Jadahh',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font10Regular(
                            color: ColorManager.hintTextColor),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50.w,
                      height: 28.h,
                      child: Stack(
                        children: List.generate(
                          3,
                          (index) => Positioned(
                            left: 12.0 * index ,
                            child: CircleAvatar(
                              radius: 14.r,
                              backgroundColor: index.isEven?
                              ColorManager.hintTextColor:ColorManager.blueColor,
                              child: Text(
                                index.toString(),
                                style: StyleManager.font10Regular(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace(8.w),
                    Flexible(
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text('3 People',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font12SemiBold(),),
                        subtitle: Text('Ahmad , rahaf, khaled',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font10Regular(),),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(DateFormat.yMd().format(DateTime.now()),style: StyleManager.font10Regular(
                              color: ColorManager.hintTextColor
                            ),),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
