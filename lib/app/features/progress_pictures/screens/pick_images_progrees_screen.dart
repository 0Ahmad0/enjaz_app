import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/app/features/progress_pictures/controller/image_project_controller.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/models/image_project.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/no_data_found_widget.dart';
import '../../core/controllers/process_controller.dart';
import '../../create_project/controller/project_controller.dart';
import '../controller/progress_projects_controller.dart';

class PickImageProgreesScreen extends StatefulWidget {
  const PickImageProgreesScreen({super.key});

  @override
  State<PickImageProgreesScreen> createState() => _PickImageProgreesScreenState();
}

class _PickImageProgreesScreenState extends State<PickImageProgreesScreen> {
  final ImagePicker _picker = ImagePicker();
  Map<String, List<File>> _groupedImages = {};

  Future<void> pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {

      await Get.put(ImageProjectController()).addImageProject(context,idProject:  controller.idProject ,files:images );
      // setState(() {
      //   String today = DateTime.now().toIso8601String().split('T')[0];
      //   if (!_groupedImages.containsKey(today)) {
      //     _groupedImages[today] = [];
      //   }
      //   _groupedImages[today]!.addAll(images.map((image) => File(image.path)));
      // });
      //
    }
  }

  late ProgressProjectsController controller;

  void initState() {
    controller = Get.put(ProgressProjectsController());
    controller.idProject= Get.put(ProjectController()).project?.id;
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(StringManager.progressPictureText),
        actions: [
          Visibility(
            visible: Get.put(ProjectController()).project?.isWorkManager??false,
            child: IconButton(
              onPressed: pickImages,
              icon: Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
      body:
         StreamBuilder<QuerySnapshot>(
    stream: controller.getImageProjects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return   ConstantsWidgets.circularProgress() ;
          } else if (snapshot.connectionState ==
              ConnectionState.active) {
            if (snapshot.hasError) {
              return  Text('Error');
            } else if (snapshot.hasData) {
              controller.imageProjects.items.clear();
              if (snapshot.data!.docs.length > 0) {

                controller.imageProjects.items =
                    ImageProjects.fromJson(snapshot.data?.docs).items;
              }
              Get.put(ProcessController()).fetchUsers(context, idUsers: controller.imageProjects.items.map((e)=>e.idUser??"").toList());
              // controller.filterProviders(term: controller.searchController.value.text);

              return
                GetBuilder<ProgressProjectsController>(
                    builder: (ProgressProjectsController progressProjectsController){
                      return
                        (progressProjectsController.imageProjects.items.isEmpty ?? true)
                            ?
                        Center(child: NoDataFoundWidget(text: "No Images Yet")):
                        buildProjects(context, progressProjectsController.imageProjects.items);});
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        })

      // _groupedImages.isEmpty ? Center()
      //     :
      // ListView.separated(
      //   itemCount: _groupedImages.keys.length,
      //   separatorBuilder: (context, index) => Divider(
      //     color: Colors.grey,
      //     thickness: 1,
      //   ),
      //   itemBuilder: (context, index) {
      //     String date = _groupedImages.keys.elementAt(index);
      //     List<File> images = _groupedImages[date]!;
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Text(
      //             date,
      //             style: TextStyle(
      //               fontSize: 18,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //         SingleChildScrollView(
      //           scrollDirection: Axis.horizontal,
      //           child: Row(
      //             children: images.map((image) {
      //               return Padding(
      //                 padding: const EdgeInsets.all(4.0),
      //                 child: Image.file(
      //                   image,
      //                   width: 100,
      //                   height: 100,
      //                   fit: BoxFit.cover,
      //                 ),
      //               );
      //             }).toList(),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // ),

    );
  }
  Widget buildProjects(BuildContext context,List<ImageProject> items){
    Map<String, List<ImageProject>> _groupedImages1 = {};
    for(ImageProject element in items){

      String today = element.dateTime?.toIso8601String().split('T')[0]??"";
      if (!_groupedImages1.containsKey(today)) {
        _groupedImages1[today] = [];
      }
      _groupedImages1[today]!.add(element);

    }
    return


      items.isEmpty ? Center()
          :
      ListView.separated(
        itemCount: _groupedImages1.keys.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        itemBuilder: (context, index) {

          String date = _groupedImages1.keys.elementAt(index);
          List<ImageProject> images = _groupedImages1[date]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: images.map((image) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:
                      Image.network(
                        image.url??"",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                      // Image.file(
                      //   image,
                      //   width: 100,
                      //   height: 100,
                      //   fit: BoxFit.cover,
                      // ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      );
  }
}
