import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) => verticalSpace(10.h),
            itemBuilder: (context, index) => ListTile(
              dense: true,
              leading: CircleAvatar(),
              title: Text(allMembers[index].name),
              trailing: InkWell(
                onTap: () {
                  setState(() {
                    allMembers[index].isAdd = !allMembers[index].isAdd;
                    if (allMembers[index].isAdd) {
                      chooseMembers.add(allMembers[index]);
                    } else {
                      chooseMembers.remove(allMembers[index]);
                    }
                  });
                },
                child: CircleAvatar(
                  backgroundColor: allMembers[index].isAdd
                      ? ColorManager.errorColor.withOpacity(.25)
                      : ColorManager.successColor.withOpacity(.25),
                  child: allMembers[index].isAdd
                      ? Icon(
                          Icons.close,
                        )
                      : Icon(Icons.add),
                ),
              ),
            ),
            itemCount: allMembers.length,
          ),
        ),
        Visibility(
          visible: chooseMembers.isNotEmpty,
          child: Container(
            color: ColorManager.grayColor,
            child: ListTile(
              title: Text('${chooseMembers.length}'),
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
}

class MemberModel {
  final String name;
  bool isAdd;

  MemberModel({
    required this.name,
    this.isAdd = false,
  });
}
