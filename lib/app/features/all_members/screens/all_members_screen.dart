import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/routing/routes.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/image_user_provider.dart';
import '../../../../core/widgets/no_data_found_widget.dart';
import '../../create_project/controller/users_controller.dart';

class AllMembersScreen extends StatefulWidget {
  const AllMembersScreen({super.key});

  @override
  State<AllMembersScreen> createState() => _AllMembersScreenState();
}

class _AllMembersScreenState extends State<AllMembersScreen> {
  late UsersController controller;

  @override
  void initState() {
    controller = Get.put(UsersController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.allMembersText),
      ),
      body:
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


    );
  }
  Widget buildMember(BuildContext context,List<UserModel> items){
    return
      // ListView.separated(
      //     itemBuilder: (context, index) => ListTile(
      //       onTap: () {
      //         context.pop();
      //         context.pushNamed(Routes.messagesRoute);
      //       },
      //       trailing: SvgPicture.asset(
      //         AssetsManager.chatIcon,
      //       ),
      //       leading: CircleAvatar(),
      //       title: Text(
      //         'Name ${++index}',
      //         style: StyleManager.font14Regular(),
      //       ),
      //     ),
      //     separatorBuilder: (_, __) => Divider(
      //       height: 0,
      //     ),
      //     itemCount: 20),

      ListView.separated(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              controller.connectionPerson(context, items[index].uid);
              // context.pop();
              // context.pushNamed(Routes.messagesRoute);
            },
            trailing: SvgPicture.asset(
              AssetsManager.chatIcon,
            ),
            leading:
            ImageUserProvider(url: items[index].photoUrl,)??
            CircleAvatar(),
            title: Text(
              items[index].name??
              'Name ${++index}',
              style: StyleManager.font14Regular(),
            ),
          ),
          separatorBuilder: (_, __) => Divider(
            height: 0,
          ),
          itemCount: items.length);


  }

}
