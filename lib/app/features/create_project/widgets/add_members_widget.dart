import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/app/features/create_project/controller/users_controller.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:enjaz_app/core/widgets/image_user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/no_data_found_widget.dart';
import '../controller/project_controller.dart';

class AddMembersWidget extends StatefulWidget {
  const AddMembersWidget({super.key});

  @override
  State<AddMembersWidget> createState() => _AddMembersWidgetState();
}

class _AddMembersWidgetState extends State<AddMembersWidget> {
  List<MemberModel> allMembers = [
    MemberModel(name: 'Ahmad'),
    MemberModel(name: 'Omar'),
    MemberModel(name: 'Khaled'),
    MemberModel(name: 'Mohamad'),
    MemberModel(name: 'Mahmod'),
    MemberModel(name: 'Hamad'),
    MemberModel(name: 'Sofian'),
    MemberModel(name: 'Faiz'),
    MemberModel(name: 'Hala'),
    MemberModel(name: 'Lina'),
  ];
  List<MemberModel> chooseMembers = [];
  late ProjectController projectController;
  late UsersController controller;

  @override
  void initState() {
    projectController = Get.put(ProjectController());
    controller = Get.put(UsersController());
    controller.onInit();
    // controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child:
          StreamBuilder<QuerySnapshot>(
              stream: controller.getUsers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return    ConstantsWidgets.circularProgress();
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasError) {
                    return  Text('Error');
                  } else if (snapshot.hasData) {
                    ConstantsWidgets.circularProgress();
                    controller.users.items.clear();
                    if (snapshot.data!.docs.length > 0) {

                      controller.users.items =
                          Users.fromJson(snapshot.data?.docs).items;
                    }
                    controller.filterUsers(term: controller.searchController.value.text);
                    return
                      GetBuilder<UsersController>(
                          builder: (UsersController usersController)=>
                          (usersController.usersWithFilter.items.isEmpty ?? true)
                              ?
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: NoDataFoundWidget(
                              text: "No Found Users",
                              // text: tr(LocaleKeys.home_no_faces_available))
                              // text: StringManager.infoNotFacesYet
                            ),
                          )
                              :

                          buildMember(context, controller.usersWithFilter.items ?? []));
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }),


        ),
        Visibility(
          visible: projectController.project?.members?.isNotEmpty??false,
          // visible: chooseMembers.isNotEmpty,
          child: Container(
            color: ColorManager.grayColor,
            child: ListTile(
              title: Text('${projectController.project?.members?.length}'),
              // title: Text('${chooseMembers.length}'),
              trailing: TextButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero
                ),
                  onPressed: (){
                    context.pop();
                  },
                  label: Text(StringManager.saveText),
                icon: Icon(Icons.bookmarks_outlined,size: 16.sp,),
              ),
            ),
          ),
        )
      ],
    );
  }
  Widget buildMember(BuildContext context,List<UserModel> items){
    return
      ListView.separated(
        separatorBuilder: (_, __) => verticalSpace(10.h),
        itemBuilder: (context, index) => ListTile(
          dense: true,
          leading: ImageUserProvider(url: items[index].photoUrl,),
          // leading: CircleAvatar(),
          title: Text(items[index].name??"name"),
          // title: Text(allMembers[index].name),
          trailing: InkWell(
            onTap: () {
              setState(() {
                allMembers[index].isAdd = !allMembers[index].isAdd;
                if (allMembers[index].isAdd) {
                  chooseMembers.add(allMembers[index]);
                } else {
                  chooseMembers.remove(allMembers[index]);
                }

                projectController.project?.members?.contains(items[index].uid)??false?
                projectController.removeMember(items[index].uid):
                projectController.addMember(idUser:items[index].uid)
                    ;


              });
            },
            child: CircleAvatar(
              backgroundColor: projectController.project?.members?.contains(items[index].uid)??false
              // backgroundColor: allMembers[index].isAdd
                  ? ColorManager.errorColor.withOpacity(.25)
                  : ColorManager.successColor.withOpacity(.25),
              child:  projectController.project?.members?.contains(items[index].uid)??false
              // child: allMembers[index].isAdd
                  ? Icon(
                Icons.close,
              )
                  : Icon(Icons.add),
            ),
          ),
        ),
        itemCount: items.length,
        // itemCount: allMembers.length,
      );


  }

}

class MemberModel {
  final String name;
  bool isAdd;

  MemberModel({
    required this.name,
    this.isAdd = false,
  });
}
