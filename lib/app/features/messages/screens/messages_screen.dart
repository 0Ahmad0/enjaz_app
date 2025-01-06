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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  context.pop();
                },
                child: Text(StringManager.deleteConversationText),
              )
            ],
          ),
        ],
        leading: CustomBackButton(),
        titleSpacing: 0,
        leadingWidth: 30.w,
        title: ListTile(
          leading: CircleAvatar(),
          title: Text(
            'Omar Alreffaie',
            style: StyleManager.font14Bold(),
          ),
          subtitle: Text(
            'Admin',
            style:
                StyleManager.font12Regular(color: ColorManager.hintTextColor),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _listMessages.isEmpty
              ? Flexible(
                  child: Center(
                    child: Text(
                      "No Messages Yet!!😢",
                      style: StyleManager.font14Bold(),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    itemCount: _listMessages.length,
                    itemBuilder: (context, index) => index.isEven
                        ? SenderTextWidget(text: _listMessages[index])
                        : ReceiverTextWidget(text: _listMessages[index]),
                  ),
                ),
          AppPaddingWidget(
            horizontalPadding: 10.w,
            child: TextField(
              controller: _messageController,
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
                      if (_messageController.text.trim().isNotEmpty)
                        _listMessages.add(_messageController.text);
                      _messageController.clear();
                      setState(() {});
                    },
                    icon: SvgPicture.asset(
                      AssetsManager.messageSendButtonIcon,
                    ),
                  ),
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AssetsManager.chatSquareIcon,
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
