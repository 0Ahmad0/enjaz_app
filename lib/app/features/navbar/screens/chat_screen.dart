import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/navbar/widgets/chat_item_widget.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/routing/routes.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:enjaz_app/core/widgets/app_search_text_filed.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/models/chat_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/no_data_found_widget.dart';
import '../../core/controllers/process_controller.dart';
import '../../messages/controller/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatController chatController;

  @override
  void initState() {
    chatController = Get.put(ChatController());
    chatController.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.chatScreenText),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(Routes.allMembersRoute);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FadeInLeft(
        child:
        StreamBuilder<QuerySnapshot>(
            stream: chatController.getChats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return    ConstantsWidgets.circularProgress();
              } else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return  Text(StringManager.emptyData);
                  // return  Text(tr(LocaleKeys.empty_data));
                } else if (snapshot.hasData) {
                  ConstantsWidgets.circularProgress();
                  chatController.chats.listChat.clear();
                  if (snapshot.data!.docs!.length > 0) {
                    chatController.chats = Chats.fromJson(snapshot.data!.docs!);
                  }
                  chatController.filterChats(term: chatController.searchController.value.text);
                  return
                    CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: AppPaddingWidget(child: AppSearchTextFiled(
                            onChanged: (value){

                              chatController.searchController.text=value??'';
                              chatController.filterChats(term: chatController.searchController.value.text);

                              setState(() {

                              });
                            },
                          )),
                        ),

              (chatController.chatsWithFilter.listChat.isEmpty)
              ?
              SliverFillRemaining(child: NoDataFoundWidget(text: "No Chats Yet")):
              buildChats(context, chatController.chatsWithFilter.listChat ?? [])

                      ],
                    );


                } else {
                  return  Text(StringManager.emptyData);
                  // return  Text(tr(LocaleKeys.empty_data));
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),

      ),
    );
  }
  Widget buildChats(BuildContext context,List<Chat> items){

    return
      GetBuilder<ChatController>(
          builder: (ChatController controller)=>

              SliverList.builder(
                  itemCount:  items.length,
                  itemBuilder: (context, index) {

                    return ChatItemWidget(item:items[index]);
                  }
              )

              // ListView.builder(
              //     itemCount:  items.length,
              //     itemBuilder: (context, index) {
              //       String? idUser=(controller.currentUserId.contains(controller.chats.listChat[index].listIdUser[0]))
              //           ?controller.chats.listChat[index].listIdUser[1]
              //           :controller.chats.listChat[index].listIdUser[0];
              //
              //       return
              //         ListTile(
              //             onTap: (){
              //               Get.put(ChatRoomController()).chat=controller.chats.listChat[index];
              //
              //               context.pushNamed(Routes.messagesRoute,arguments: {
              //                 'index':index.toString(),
              //                 'chat':controller.chats.listChat[index]
              //               });
              //               // context.pushNamed(Routes.messagesRoute);
              //             },
              //             contentPadding: EdgeInsets.zero,
              //             dense: true,
              //             leading:       GetBuilder<ProcessController>(
              //                 builder: (ProcessController processController) {
              //                   processController.fetchUserAsync(context, idUser: idUser);
              //                   UserModel? user = processController.fetchLocalUser(idUser: idUser);
              //                   return ImageUserProvider(
              //                     url: user?.photoUrl,
              //                   );}),
              //             title:
              //             fetchName(context,  idUser  ),
              //             // Text(
              //             //   'البائع',
              //             //   style: StyleManager.font14SemiBold(),
              //             // ),
              //             trailing:
              //
              //             fetchTimeLastMessage(context,controller.chats.listChat[index].id),
              //             subtitle:
              //             fetchLastMessage(context,controller.chats.listChat[index].id)
              //           // Text(
              //           //   'آخر رسالة...',
              //           //   maxLines: 1,
              //           //   overflow: TextOverflow.ellipsis,
              //           //   style: StyleManager.font12Regular(),
              //           // ),
                      );




  }


}
