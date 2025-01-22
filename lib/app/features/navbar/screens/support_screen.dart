import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:enjaz_app/app/features/navbar/controller/report_controller.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/const_value_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/app_button.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:enjaz_app/core/widgets/app_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/helpers/spacing.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: color, width: 1.sp));

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int _currentIndex = -1;
  int _currentIndexOption = -1;
  int _currentIndexRate = -1;
  String? selectIssue;
  List<File?> _files = [];
  late ReportController controller;
  final _descriptionController=TextEditingController();
  @override
  void initState() {
    controller = Get.put(ReportController());
    controller.onInit();
    controller.report=null;
    super.initState();
  }
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
  Future<bool> validateReport(BuildContext context) async {
    String? error;

    if(_currentIndexRate==-1){
      error="Please select rate";
    }

    if(_descriptionController.value.text?.isEmpty??true){
      error="Please Enter description";
    }

    if(selectIssue?.isEmpty??true){
      error="Please select issue";
    }
    if(_currentIndexOption==-1){
      error="Please select contact option";
    }
    if(_currentIndex==-1){
      error="Please select frequently asked question";
    }
    if(error!=null)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );

    return error==null;
  }

  Future<void> _addReport(BuildContext context) async {
    if ((await validateReport(context))) {
      // if (_selectedToolImage == null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('الرجاء اختيار صورة للمنتج')),
      //   );
      //   return;
      // }
      controller.addReport(context,
          issue:selectIssue ,
          description:_descriptionController.text ,
          isSatisfied:_currentIndexRate==0 ,
          contactOption:ConstValueManager.contactOptionList[_currentIndexOption],
          frequentlyAskedQuestion: ConstValueManager
              .technicalSupportAskedQuestionList[_currentIndex],

          files: _files);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.technicalSupportText),
        actions: [IconButton(onPressed: () {
          _addReport(context);
        }, icon: Icon(Icons.add))],
      ),
      body: FadeInLeft(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Theme(
                data:
                    Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: StatefulBuilder(builder: (context, askedQuestionSetState) {
                  return ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      StringManager.frequentlyAskedQuestionText,
                      style: StyleManager.font14Bold(),
                    ),
                    children: List.generate(
                      ConstValueManager.technicalSupportAskedQuestionList.length,
                      (index) => AppPaddingWidget(
                        verticalPadding: 0,
                        child: ListTile(
                          onTap: () {
                            askedQuestionSetState(() {
                              _currentIndex = index;
                            });
                          },
                          dense: true,
                          title: Text(
                            ConstValueManager
                                .technicalSupportAskedQuestionList[index],
                            style: StyleManager.font12Regular(
                              color: _currentIndex == index
                                  ? ColorManager.blueColor
                                  : ColorManager.hintTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              AppPaddingWidget(
                  child: Text(
                StringManager.contactOptionText,
                style: StyleManager.font14Bold(),
              )),
              StatefulBuilder(builder: (context, listSetState) {
                return AppPaddingWidget(
                  verticalPadding: 0,
                  child: SizedBox(
                    height: 40.h,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                              borderRadius: BorderRadius.circular(24.r),
                              onTap: () {
                                listSetState(() {
                                  _currentIndexOption = index;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                ),
                                decoration: BoxDecoration(
                                    color: _currentIndexOption == index
                                        ? ColorManager.primaryColor
                                        : ColorManager.grayColor,
                                    borderRadius: BorderRadius.circular(100.r)),
                                duration: Duration(milliseconds: 300),
                                child: Text(
                                  ConstValueManager.contactOptionList[index],
                                  style: StyleManager.font12Regular(
                                    color: _currentIndexOption == index
                                        ? ColorManager.whiteColor
                                        : ColorManager.blackColor,
                                  ),
                                ),
                              ),
                            ),
                        separatorBuilder: (_, __) => horizontalSpace(10.w),
                        itemCount: ConstValueManager.contactOptionList.length),
                  ),
                );
              }),
              AppPaddingWidget(
                  child: Text(
                StringManager.reportAnIssueText,
                style: StyleManager.font14Bold(),
              )),
              AppPaddingWidget(
                verticalPadding: 0,
                child: DropdownButtonFormField(
                    hint: Text(
                      StringManager.selectTheIssueText,
                      style: StyleManager.font16Regular(
                        color: ColorManager.hintTextColor,
                      ),
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      focusedBorder: _borderTextFiled(),
                      border: _borderTextFiled(color: Colors.transparent),
                      enabledBorder: _borderTextFiled(color: Colors.transparent),
                      errorBorder:
                          _borderTextFiled(color: ColorManager.errorColor),
                      filled: true,
                      fillColor: ColorManager.grayColor,
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: ["1", "2", "3"]
                        .map((e) => DropdownMenuItem(
                              child: Text(
                                e.toString(),
                              ),
                              value: e.toString(),
                            ))
                        .toList(),
                    onChanged: (value) {
                      selectIssue="${value}";
                    }),
              ),
              AppPaddingWidget(
                child: AppTextField(
                  controller: _descriptionController,
                  minLine: 4,
                  maxLine: 8,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  hintText: StringManager.describeTheIssueText,
                ),
              ),
              AppPaddingWidget(
                verticalPadding: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () {
                    _pickMultipleFile();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: ColorManager.grayColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Text(
                          StringManager.attachFilesText,
                          style: StyleManager.font14Regular(
                            color: ColorManager.hintTextColor,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Visibility(
                                visible: _files.isNotEmpty,
                                child: Text(
                                  '${_files.length} Files',
                                  style: StyleManager.font12Regular(
                                    color: ColorManager.blueColor
                                  ),
                                )),
                            horizontalSpace(4.w),
                            Icon(
                              Icons.attach_file,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              AppPaddingWidget(
                child: Text(
                  StringManager.rateOurServiceText,
                  style: StyleManager.font14Bold(),
                ),
              ),
              AppPaddingWidget(
                verticalPadding: 0,
                child: StatefulBuilder(
                  builder: (context,rateSetState) {
                    return Row(
                      children: [
                        Flexible(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: (){
                              rateSetState((){
                                _currentIndexRate = 0;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 20.h
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: _currentIndexRate == 0
                                      ?ColorManager.primaryColor
                                      :ColorManager.grayColor
                              ),
                              child: Text(
                                StringManager.satisfiedText,
                                style: StyleManager.font12Regular(
                                    color: _currentIndexRate == 0
                                        ?ColorManager.whiteColor
                                        :ColorManager.primaryColor
                                ),
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(10.w),
                        Flexible(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: (){
                              rateSetState((){
                                _currentIndexRate = 1;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 20.h

                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: _currentIndexRate == 1
                                      ?ColorManager.primaryColor
                                      :ColorManager.grayColor
                              ),
                              child: Text(
                                StringManager.notSatisfiedText,
                                style: StyleManager.font12Regular(
                                    color: _currentIndexRate == 1
                                        ?ColorManager.whiteColor
                                        :ColorManager.primaryColor
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
