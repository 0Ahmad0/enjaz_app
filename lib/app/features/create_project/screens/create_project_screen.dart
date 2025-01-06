import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:enjaz_app/app/features/all_members/screens/all_members_screen.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/app/features/create_project/widgets/add_members_widget.dart';
import 'package:enjaz_app/app/features/create_project/widgets/pick_project_location_widget.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/routing/routes.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:enjaz_app/core/widgets/app_textfield.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  File? _file;

  List<File?> _files = [];

  _pickMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      _files = result.paths.map((path) => File(path!)).toList();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select atleast 1 file'),
      ));
    }
  }

  _pickImage() async {
    ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      _file = File(result.path);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select image'),
      ));
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.createProjectText),
        leading: CustomBackButton(),
      ),
      body: FadeInDown(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: AppPaddingWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringManager.projectNameText,
                        style: StyleManager.font14Bold(),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        hintText: StringManager.nameOfProjectText,
                      ),
                      verticalSpace(20.h),
                      Text(
                        StringManager.projectPictureText,
                        style: StyleManager.font14Bold(),
                      ),
                      verticalSpace(10.h),
                      InkWell(
                        borderRadius: BorderRadius.circular(14.r),
                        onTap: () {
                          _pickImage();
                        },
                        child: DottedBorder(
                          radius: Radius.circular(14.r),
                          color: ColorManager.hintTextColor,
                          borderType: BorderType.RRect,
                          dashPattern: [0, 4, 8],
                          child: Container(
                            alignment: Alignment.center,
                            height: 180.h,
                            decoration: BoxDecoration(
                                color: ColorManager.grayColor,
                                borderRadius: BorderRadius.circular(14.r)),
                            child: _file == null
                                ? SvgPicture.asset(
                                    AssetsManager.uploadPictureIcon)
                                : Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        child: Image.file(
                                          File(_file!.path),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _file = null;
                                          setState(() {});
                                        },
                                        icon: CircleAvatar(
                                            backgroundColor:
                                                ColorManager.errorColor,
                                            child: Icon(
                                              Icons.delete,
                                              color: ColorManager.whiteColor,
                                            )),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      verticalSpace(20.h),
                      Text(
                        StringManager.projectDescriptionText,
                        style: StyleManager.font14Bold(),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        minLine: 1,
                        maxLine: 4,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        hintText: StringManager.describeTheProjectText,
                      ),
                      verticalSpace(20.h),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          StringManager.addMembersText,
                          style: StyleManager.font14Bold(),
                        ),
                        trailing: TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                showDragHandle: true,
                                enableDrag: true,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(14.r))),
                                context: context,
                                builder: (_) => AddMembersWidget());
                          },
                          icon: Icon(
                            Icons.add,
                            size: 20.sp,
                            color: ColorManager.blueColor,
                          ),
                          label: Text(
                            StringManager.addText,
                            style: StyleManager.font14Bold(
                                color: ColorManager.blueColor),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 56.w,
                            height: 28.h,
                            child: Stack(
                              children: List.generate(
                                3,
                                (index) => Positioned(
                                  left: 12.0 * index,
                                  child: CircleAvatar(
                                    radius: 14.r,
                                    backgroundColor: index.isEven
                                        ? ColorManager.hintTextColor
                                        : ColorManager.blueColor,
                                    child: Text(
                                      index.toString(),
                                      style: StyleManager.font10Regular(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          horizontalSpace(8.w),
                          Flexible(
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                '3 People',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: StyleManager.font12SemiBold(),
                              ),
                              subtitle: Text(
                                'Ahmad , rahaf, khaled',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: StyleManager.font10Regular(),
                              ),
                            ),
                          )
                        ],
                      ),
                      verticalSpace(20.h),
                      Text(
                        StringManager.projectDateText,
                        style: StyleManager.font14Bold(),
                      ),
                      verticalSpace(10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringManager.startDateText,
                                  style: StyleManager.font14Bold(),
                                ),
                                verticalSpace(10.h),
                                AppTextField(
                                  iconData: AssetsManager.dateIcon,
                                  controller: _startDateController,
                                  readOnly: true,
                                  onTap: () async {
                                    final datePicker = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2040));
                                    if (datePicker != null) {
                                      _startDateController.text =
                                          DateFormat.yMd().format(datePicker);
                                      setState(() {});
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Please select Date'),
                                      ));
                                    }
                                  },
                                  hintText:
                                      DateFormat.yMd().format(DateTime.now()),
                                )
                              ],
                            ),
                          ),
                          horizontalSpace(10.w),
                          Expanded(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringManager.endDateText,
                                  style: StyleManager.font14Bold(),
                                ),
                                verticalSpace(10.h),
                                AppTextField(
                                  iconData: AssetsManager.dateIcon,
                                  controller: _endDateController,
                                  readOnly: true,
                                  onTap: () async {
                                    final datePicker = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2040));
                                    if (datePicker != null) {
                                      _endDateController.text =
                                          DateFormat.yMd().format(datePicker);
                                      setState(() {});
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Please select Date'),
                                      ));
                                    }
                                  },
                                  hintText:
                                      DateFormat.yMd().format(DateTime.now()),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20.h),
                      Text(
                        StringManager.projectLocationText,
                        style: StyleManager.font14Bold(),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        readOnly: true,
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => PickProjectLocationWidget(),
                          );
                        },
                        hintText: StringManager.projectLocationHintText,
                      ),
                      verticalSpace(10.h),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          StringManager.projectAssetsText,
                          style: StyleManager.font14Bold(),
                        ),
                        trailing: TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            context.pushNamed(
                              Routes.projectAssetsListRoute
                            );
                          },
                          icon: Icon(
                            Icons.add,
                            size: 20.sp,
                            color: ColorManager.blueColor,
                          ),
                          label: Text(
                            StringManager.addText,
                            style: StyleManager.font14Bold(
                                color: ColorManager.blueColor),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: InkWell(
                onTap: () {},
                child: AppPaddingWidget(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.bookmarks_outlined,
                        color: ColorManager.blueColor,
                        size: 16.sp,
                      ),
                      horizontalSpace(4.w),
                      Text(
                        StringManager.saveText,
                        style: StyleManager.font14Regular(
                            color: ColorManager.blueColor),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
