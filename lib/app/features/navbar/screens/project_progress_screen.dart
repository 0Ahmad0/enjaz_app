import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/create_project/controller/project_controller.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/models/project_model.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/const_value_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/app_padding.dart';
import '../../../../core/widgets/app_search_text_filed.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/no_data_found_widget.dart';
import '../controller/projects_controller.dart';
import '../widgets/progress_project_item_widget.dart';

class ProjectProgressScreen extends StatefulWidget {
  const ProjectProgressScreen({super.key});

  @override
  State<ProjectProgressScreen> createState() => _ProjectProgressScreenState();
}

class _ProjectProgressScreenState extends State<ProjectProgressScreen> {
  int _currentIndex = 0;
  late ProjectsController controller;

  void initState() {
    controller = Get.put(ProjectsController());
    controller.onInit();
    super.initState();
  }
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
                    onChanged: (value){
                      controller.searchController.text=value??"";
                      controller.filterProviders(term: value??"");
                      controller.classification();
                      // _sort();
                    },
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
                                    controller.update();
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
              StreamBuilder<QuerySnapshot>(
                  stream: controller.getProjects,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return   SliverToBoxAdapter(child: ConstantsWidgets.circularProgress(),) ;
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasError) {
                        return  SliverToBoxAdapter(child: Text('Error'));
                      } else if (snapshot.hasData) {
                        controller.projects.items.clear();
                        if (snapshot.data!.docs.length > 0) {

                          controller.projects.items =
                              Projects.fromJson(snapshot.data?.docs).items;
                        }
                        controller.filterProviders(term: controller.searchController.value.text);
                        controller.classification();

                        return
                          GetBuilder<ProjectsController>(
                              builder: (ProjectsController projectsController){
                                List<ProjectModel> items=(_currentIndex==0?projectsController.activeProject:
                                _currentIndex==1?projectsController.completedProjects:projectsController.projectsWithFilter).items;
                                return
                              (items.isEmpty ?? true)
                                  ?
                              SliverFillRemaining(child: NoDataFoundWidget(text: "No Projects Yet")):
                              buildProjects(context, items);});
                      } else {
                        return SliverToBoxAdapter(child: const Text('Empty data'));
                      }
                    } else {
                      return SliverToBoxAdapter(child: Text('State: ${snapshot.connectionState}'));
                    }
                  })

            ],
          ),
        ),
      ),
    );
  }
  Widget buildProjects(BuildContext context,List<ProjectModel> items){
    return


    SliverList.builder(
      itemBuilder: (context, index) => ProgressProjectItemWidget(
        status:items[index].getState??ProjectStatus.inProgress,
        item:items[index]
        // status: ConstValueManager.projectWithStatusList[index],
      ),
      itemCount: items.length,
      // itemCount: ConstValueManager.projectWithStatusList.length,
    );
  }
}
