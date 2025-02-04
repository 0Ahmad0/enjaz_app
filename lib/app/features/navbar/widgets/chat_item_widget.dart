import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/models/chat_model.dart';
import 'package:enjaz_app/core/routing/routes.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/image_user_provider.dart';
import '../../core/controllers/process_controller.dart';
import '../../messages/controller/chat_controller.dart';
import '../../messages/controller/chat_room_controller.dart';

class ChatItemWidget extends StatelessWidget {
   ChatItemWidget({super.key, this.item});
final Chat? item;
  final ProcessController _processController = Get.put(ProcessController());
   final controller=Get.put(ChatController());
  @override
  Widget build(BuildContext context) {

    String? idUser=(controller.currentUserId.contains(item?.listIdUser[0]??''))
        ?item?.listIdUser.elementAtOrNull(1)
        :item?.listIdUser[0];
    return InkWell(
      onTap: (){
        Get.put(ChatRoomController()).chat=item;

        context.pushNamed(Routes.messagesRoute,
            arguments: {
              'chat':item
            }
        );
        // context.pushNamed(Routes.messagesRoute);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child:


            ListTile(
              leading:
              GetBuilder<ProcessController>(
                  builder: (ProcessController processController) {
                    processController.fetchUserAsync(context, idUser: idUser??'');
                    UserModel? user = processController.fetchLocalUser(idUser: idUser??'');
                    return ImageUserProvider(
                      url: user?.photoUrl,
                    );}),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //       'https://th.bing.com/th/id/OIP.iPjtJwLhXF9N9Vd2OzyerwHaHa?rs=1&pid=ImgDetMain'),
              // ),
              title:
              item?.name?.isNotEmpty??false?
              Text(
                item?.name??'',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font14Bold(),
              ):
              fetchName(context,  idUser??"Rakan Alshareef"  ),

              // Text(
              //   'Rakan Alshareef',
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: StyleManager.font14Bold(),
              // ),
              subtitle:
              fetchLastMessage(context,item?.id?? "Last Message Sent"),
              // Text(
              //   "Last Message Sent",
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: StyleManager.font12SemiBold(
              //       color: ColorManager.hintTextColor),
              // ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetBuilder<ProcessController>(
                    builder: (ProcessController processController) {
                      processController.fetchUserAsync(context, idUser: idUser??'');
                      UserModel? user = processController.fetchLocalUser(idUser: idUser??'');
                      return  Text(
                        item?.idGroup?.isNotEmpty??false?
                        '● Group'
                            :
                        '● ${user?.typeUser??""}',
                        // '● Admin',
                        style: StyleManager.font12SemiBold(color: ColorManager.blueColor),
                      );}),

                verticalSpace(20.h),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                fetchTimeLastMessage(context,item?.id?? "just Now"),
                // Text(
                //   'just Now',
                //   style: StyleManager.font12Regular(
                //       color: ColorManager.blackColor.withOpacity(.75)),
                // ),
                verticalSpace(10.h),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Badge.count(
                    count: 3,
                    backgroundColor: ColorManager.errorColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  fetchName(BuildContext context,String idUser){
    return _processController.widgetNameUser(context, idUser: idUser,style:  StyleManager.font14SemiBold());
  }
  fetchLocalUser(BuildContext context,String idUser){
    return _processController.fetchUser(context, idUser: idUser);
  }
  fetchLastMessage(BuildContext context,String idChat){
    return Get.put(ChatController()).widgetLastMessage(context, idChat: idChat);
  }
  fetchTimeLastMessage(BuildContext context,String idChat){
    return Get.put(ChatController()).widgetTimeLastMessage(context, idChat: idChat);
  }
}
