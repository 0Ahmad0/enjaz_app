import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/helpers/sizer.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/helpers/operation_file.dart';
import '../../../../core/models/message_model.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/image_user_provider.dart';
import '../../core/controllers/process_controller.dart';
import '../controller/chat_controller.dart';
import '../controller/chat_room_controller.dart';
import '../widgets/file_widget.dart';
import '../widgets/receiver_text_widget.dart';
import '../widgets/sender_text_widget.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.r),
        borderSide: BorderSide(color: color, width: 1.sp));

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _messageController = TextEditingController();
  List<String> _listMessages = [];

  late ChatRoomController controller;
  var args;
  var initData;
  @override
  void initState() {
    controller = Get.put(ChatRoomController());
    // messageController.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }



  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    Get.lazyPut(() => ProcessController());
    ProcessController.instance.fetchUser(context,idUser: controller.recId??'');
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: (){
                  Get.put(ChatController()).deleteChat(context, idChat: controller.chat?.id??'');
                  // context.pop();
                },
                child: Text(StringManager.deleteConversationText),
              )
            ],
          ),
        ],
        leading: CustomBackButton(),
        titleSpacing: 0,
        leadingWidth: 30.w,
        title:

        GetBuilder<ProcessController>(
          builder: (ProcessController processController) =>
              ListTile(
                leading:  ImageUserProvider(
              url:  '${processController.fetchLocalUser(idUser: controller.recId ?? '')?.photoUrl ?? ''}',
        )??CircleAvatar(),
                title:
                controller.chat?.name?.isNotEmpty??false?
                Text(
              controller.chat?.name??'',
                  style: StyleManager.font14Bold(),
                ):
                Text(
                  '${processController.fetchLocalUser(idUser: controller.recId ?? 'Loading ..')?.name ?? 'Loading ..'}',
                  style: StyleManager.font14Bold(),
                ),

                // Text(
                //   'Omar Alreffaie',
                //   style: StyleManager.font14Bold(),
                // ),
                subtitle: Text(
                  controller.chat?.idGroup?.isNotEmpty??false?
                  '● Group':
                  '${processController.fetchLocalUser(idUser: controller.recId ?? 'Loading ..')?.typeUser ?? 'Loading ..'}',
                  // 'Admin',
                  style:
                  StyleManager.font12Regular(color: ColorManager.hintTextColor),
                ),
              ),
        )

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child:
      StreamBuilder<QuerySnapshot>(
          stream: controller.getChat,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return    ConstantsWidgets.circularProgress();
            } else if (snapshot.connectionState ==
                ConnectionState.active) {
              if (snapshot.hasError) {
                return  Text(StringManager.emptyData);
                // return  Text(tr(LocaleKeys.empty_data));
              } else if (snapshot.hasData) {

                // ConstantsWidgets.circularProgress();
                controller.chat?.messages.clear();
                if (snapshot.data!.docs!.length > 1) {
                  controller.chat?.messages =
                      Messages.fromJson(snapshot.data!.docs!).listMessage;
                }

                return GetBuilder<ChatRoomController>(
                    init: controller,
                    builder: (ChatRoomController chatRoomController){
                      Message? message=controller.waitMessage.lastOrNull;
                      message?.checkSend=false;
                      if(message!=null)
                        controller.chat?.messages.add( message);

                      return
                        buildChat(context,controller.chat?.messages ?? []);
                    });

              } else {
                return  Text(StringManager.emptyData);
                // return  Text(tr(LocaleKeys.empty_data));
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),)
          ,
          AppPaddingWidget(
            horizontalPadding: 10.w,
            child: TextField(
              controller: controller.messageController,
              // controller: _messageController,
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                  focusedBorder: _borderTextFiled(),
                  border: _borderTextFiled(color: Colors.transparent),
                  enabledBorder: _borderTextFiled(color: Colors.transparent),
                  errorBorder: _borderTextFiled(color: ColorManager.errorColor),
                  iconColor: ColorManager.grayColor,
                  filled: true,
                  fillColor: ColorManager.grayColor,
                  suffixIcon: IconButton(
                    onPressed: () {
                      sendText();
                      // if (_messageController.text.trim().isNotEmpty)
                      //   {
                      //   _listMessages.add(_messageController.text);
                      // _messageController.clear();
                      //

                        // }
                      // setState(() {});
                    },
                    icon: SvgPicture.asset(
                      AssetsManager.messageSendButtonIcon,
                    ),
                  ),
                  prefixIcon: IconButton(
                      onPressed: () async {
                        pickerFiles();
                        // final file = await
                        // FilePicker.platform.pickFiles();
                        //ToDo : chose pdf and get file name
                      },
                      icon: SvgPicture.asset(
                        AssetsManager.chatSquareIcon,
                      ))),
            ),
          )
        ],
      ),
    );
  }
  Widget buildChat(BuildContext context, List<Message> messages) {
    controller.chatList = messages;


    return controller.chatList.isEmpty
        ?  Flexible(
      child: Center(
        child: Text(
          "No Messages Yet!!😢",
          style: StyleManager.font14Bold(),
        ),
      ),
    )
        :
    ListView.builder(
        padding:
        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        itemCount:  messages.length,
        itemBuilder: (context, index) =>
        messages[index].typeFile!=TypeMessage.file.name
            ? SenderTextWidget(
            item: messages[index],
            text: messages[index].textMessage,isCurrentUser:
        controller.chatList[index].senderId ==
            controller.currentUserId)
            :FileWidget(
          idGroup:controller.chat?.idGroup ,
            item: messages[index],
            isCurrentUser:
        controller.chatList[index].senderId ==
            controller.currentUserId)
      // :ReceiverTextWidget(text: _listMessages[index]),
    );
  }
  pickerFiles() async {
    final file = FilePicker.platform;
    FilePickerResult? filePickerResult= await file.pickFiles(allowMultiple:true,
      type: FileType.custom, // لتحديد نوع مخصص من الملفات
      allowedExtensions: ['pdf'], // السماح فقط بملفات PDF
    );
    for(PlatformFile platformFile in filePickerResult?.files??[])
    {
      await controller.sendMessage(
        context,
        idChat: controller.chat?.id ?? '',
        message: Message(
          // textMessage: 'Audio message',
          textMessage: platformFile.name+'-${Timestamp.now().microsecondsSinceEpoch}',
          sizeFile: ( platformFile?.size)??0,
          typeMessage: TypeMessage.file.name,
          typeFile: getFileType(platformFile.path).name,
          senderId: controller.currentUserId,
          receiveId: controller.recId ?? '',
          sendingTime: DateTime.now(),
          localUrl: platformFile?.path??'',
        ),
      );
      controller.update();
      // Get.put(GuestProblemController()).addFile(platformFile.xFile,platformFile: platformFile,type: TypeFile.file.name);
    }
  }
  sendText() async {
    print("object");
    if (controller.messageController.value.text.trim().isNotEmpty) {
      String message = controller.messageController.value.text;
      controller.messageController.clear();
      await controller.sendMessage(
        context,
        idChat: controller.chat?.id ?? '',
        message: Message(
          textMessage: message,
          typeMessage: TypeMessage.text.name,
          senderId: controller.currentUserId,
          receiveId: controller.recId ?? '',
          sendingTime: DateTime.now(),
        ),
      );
      controller.update();
      Get.put(ChatController()).update();
    }
  }
}
