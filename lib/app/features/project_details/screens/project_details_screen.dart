import 'dart:io';

import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/profile/controller/profile_controller.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/models/file_model.dart';
import 'package:enjaz_app/core/routing/routes.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/const_value_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/app_padding.dart';
import '../../create_project/controller/project_controller.dart';
import '../../progress_pictures/screens/pick_images_progrees_screen.dart';
import '../controller/report_project_controller.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  int _currentIndex = 0;
  late ProjectController controller;
  @override
  void initState() {
    controller = Get.put(ProjectController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    controller.project=args?["project"];

    return Scaffold(
      floatingActionButton: Visibility(
        /// ToDO: Check The User Is Manager Project
        // visible: controller.project?.idUser== Get.put(ProfileController()).currentUser.value?.uid,
        visible: (_currentIndex == 0&&(controller.project?.isWorkManager??false))
        ||(_currentIndex == 1&&!(controller.project?.isWorkManager??false)),
        child: FloatingActionButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom, // لتحديد نوع مخصص من الملفات
              allowedExtensions: ['pdf'], // السماح فقط بملفات PDF
              allowMultiple: false,

            );

            if (result != null) {
              final files = result.paths.map((path) => File(path!)).toList();
              FileModel fileModel=FileModel(
                  name:XFile( files.first.path).name,
                  localUrl: files.first.path,
                  size: await files.first.length(),
                  type: TypeFile.file.name,
                  subType:files.first.path.split('/').last.split('.').last);
                  Get.put(ReportProjectController()).addReportProject(context,file: fileModel,idProject: controller.project?.id
                  ,state: controller.project?.isWorkManager??false?AccountRequestStatus.Accepted.name:null);
             
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please select atleast 1 file'),
              ));
            }
        
            //TODO : Here Upload New Report As File
          },
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (_)=> PickImageProgreesScreen()
              ));
              // context.pushNamed(Routes.progressPictureRoute);
            },
            icon: Padding(
              padding: EdgeInsets.all(8.sp),
              child: SvgPicture.asset(
                AssetsManager.bookmarkIcon,
                colorFilter: ColorFilter.mode(
                  ColorManager.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          )
        ],
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
                        borderRadius: BorderRadius.circular(100.r)),
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
                itemCount: ConstValueManager.projectDetailsList.length,
              ),
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
