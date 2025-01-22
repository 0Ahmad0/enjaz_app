import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/app/features/project_details/widgets/reports_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/models/project_model.dart';
import '../../../../core/models/report_project.dart';
import '../../../../core/utils/const_value_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/no_data_found_widget.dart';
import '../../core/controllers/process_controller.dart';
import '../../create_project/controller/project_controller.dart';
import '../controller/report_projects_controller.dart';
import '../widgets/assets_item_widget.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {

  late ReportProjectsController controller;

  void initState() {
    controller = Get.put(ReportProjectsController());
    controller.idProject= Get.put(ProjectController()).project?.id;
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: controller.getReportProjects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return   ConstantsWidgets.circularProgress() ;
          } else if (snapshot.connectionState ==
              ConnectionState.active) {
            if (snapshot.hasError) {
              return  Text('Error');
            } else if (snapshot.hasData) {
              controller.reportProjects.items.clear();
              if (snapshot.data!.docs.length > 0) {

                controller.reportProjects.items =
                    ReportProjects.fromJson(snapshot.data?.docs).items;
              }
              Get.put(ProcessController()).fetchUsers(context, idUsers: controller.reportProjects.items.map((e)=>e.idUser??"").toList());
              // controller.filterProviders(term: controller.searchController.value.text);

              return
                GetBuilder<ReportProjectsController>(
                    builder: (ReportProjectsController reportProjectsController){
                     return
                        (reportProjectsController.reportProjects.items.isEmpty ?? true)
                            ?
                        NoDataFoundWidget(text: "No Reports Yet"):
                        buildProjects(context, reportProjectsController.reportProjects.items);});
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        });
  }
  Widget buildProjects(BuildContext context,List<ReportProject> items){
    return


      ZoomIn(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h
          ),
          itemBuilder: (context, index) {
            final item =items[index];

            // final item = ConstValueManager.assetsList[index];
            return
              GetBuilder<ProcessController>(
                builder: (ProcessController processController)=>
              ReportsItemWidget(
                url: item.file?.url,
              image:processController
                  .fetchLocalUser(idUser: item.idUser??"")?.photoUrl?? null,
              name: processController
                  .fetchLocalUser(idUser: item.idUser??"")?.name??item.nameUser??'Omar Alrefaee',
              date: DateFormat.yMd().add_jm().format(item.dateTime??DateTime.now()),
            ));
            // return ReportsItemWidget(
            //   image: item.image,
            //   name: 'Omar Alrefaee',
            //   date: DateFormat.yMd().add_jm().format(DateTime.now()),
            // );
          },
          itemCount: items.length,
          // itemCount: ConstValueManager.assetsList.length,
          separatorBuilder: (_,__)=>verticalSpace(20.h),
        ),
      );
  }
}
