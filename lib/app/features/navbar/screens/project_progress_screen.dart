import 'package:animate_do/animate_do.dart';
import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/const_value_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/app_padding.dart';
import '../../../../core/widgets/app_search_text_filed.dart';
import '../widgets/progress_project_item_widget.dart';

class ProjectProgressScreen extends StatefulWidget {
  const ProjectProgressScreen({super.key});

  @override
  State<ProjectProgressScreen> createState() => _ProjectProgressScreenState();
}

class _ProjectProgressScreenState extends State<ProjectProgressScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(Routes.createProjectRoute);
        },
        child: Icon(Icons.add,),
      ),
      body: SafeArea(
        child: FadeInLeft(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppPaddingWidget(
                  child: AppSearchTextFiled(
                    hintText: StringManager.searchProjectText,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: StatefulBuilder(builder: (context, listSetState) {
                  return AppPaddingWidget(
                    verticalPadding: 0,
                    child: SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                                borderRadius: BorderRadius.circular(100.r),
                                onTap: () {
                                  listSetState(() {
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
                                    ConstValueManager.projectStatusList[index],
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
                              ConstValueManager.projectStatusList.length),
                    ),
                  );
                }),
              ),
              SliverList.builder(
                itemBuilder: (context, index) => ProgressProjectItemWidget(),
                itemCount: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
