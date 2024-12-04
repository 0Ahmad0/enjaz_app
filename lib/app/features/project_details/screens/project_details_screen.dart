import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/const_value_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/app_padding.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(StringManager.projectDetailsText),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: verticalSpace(12.h),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    borderRadius: BorderRadius.circular(100.r),
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? ColorManager.primaryColor
                              : ColorManager.grayColor,
                          borderRadius:
                          BorderRadius.circular(100.r)),
                      duration: Duration(milliseconds: 300),
                      child: Text(
                        ConstValueManager.projectDetailsList[index].label,
                        style: StyleManager.font12Regular(
                          color: _currentIndex == index
                              ? ColorManager.whiteColor
                              : ColorManager.blackColor,
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (_, __) => horizontalSpace(10.w),
                  itemCount:
                  ConstValueManager.projectDetailsList.length),
            ),
          ),
          SliverFillRemaining(
            child: ConstValueManager.projectDetailsList[_currentIndex].screen,
          )

        ],
      ),
    );
  }
}
