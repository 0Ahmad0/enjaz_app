import 'dart:convert';

import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/app_button.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/widgets/constants_widgets.dart';
import 'package:http/http.dart' as http;
class PickProjectLocationWidget extends StatefulWidget {
  const PickProjectLocationWidget({super.key, this.confirmLocation});
  final Function(LatLng? selectedLocation,String? address)? confirmLocation;


  @override
  State<PickProjectLocationWidget> createState() =>
      _PickProjectLocationWidgetState();
}

class _PickProjectLocationWidgetState extends State<PickProjectLocationWidget> {
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;
  String? areaName;
  void _onMapTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  Future<void> _confirmLocation() async {
    if (LatLng != null) {
      await getAreaName(_selectedLocation?.latitude,_selectedLocation?.longitude);
      widget.confirmLocation!=null? widget.confirmLocation!(_selectedLocation,areaName):"";
      Navigator.pop(context, _selectedLocation);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء اختيار موقع من الخريطة')),
      );
    }
  }

  // void _confirmLocation() {
  //   if (_selectedLocation != null) {
  //     Navigator.pop(context, _selectedLocation);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('الرجاء اختيار موقع من الخريطة')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        print('object');
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Material(
          clipBehavior: Clip.none,
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(14.r)),
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          StringManager.pickLocationText,
                          style: StyleManager.font16SemiBold(
                              color: ColorManager.whiteColor),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(24.7136, 46.6753),
                            zoom: 10.0,
                          ),
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                          onTap: _onMapTap,
                          markers: _selectedLocation != null
                              ? {
                                  Marker(
                                    markerId: MarkerId('selected'),
                                    position: _selectedLocation!,
                                  ),
                                }
                              : {},
                        ),
                        Visibility(
                          visible: _selectedLocation != null,
                          child: AppPaddingWidget(
                            child: AppButton(
                                onPressed: _confirmLocation,
                                text: StringManager.pickLocationText
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              PositionedDirectional(
                end: 0,
                child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.whiteColor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> getAreaName(double? latitude, double? longitude) async {
    ConstantsWidgets.showLoading();

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final address = data['address'];
      final area = address['suburb'] ??
          address['municipality'] ??
          address['province'] ??
          address['state'] ??
          address['country'] ??
          'غير معروف';
      print(address);
      setState(() {
        areaName = area;
      });
    } else {
      setState(() {
        areaName = 'غير معروف';
      });
    }
    ConstantsWidgets.closeDialog();
  }
}
