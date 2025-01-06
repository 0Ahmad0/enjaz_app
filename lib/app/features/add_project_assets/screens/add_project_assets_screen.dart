import 'dart:io';

import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/widgets/app_button.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:enjaz_app/core/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AssetModel {
  final String image;
  final String name;
  final String price;
  final String quantity;
  final String total;

  AssetModel({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
  });
}



class AddProjectAssetsScreen extends StatefulWidget {
  @override
  _AddProjectAssetsScreenState createState() => _AddProjectAssetsScreenState();
}

class _AddProjectAssetsScreenState extends State<AddProjectAssetsScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _addProduct(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الرجاء اختيار صورة للمنتج')),
        );
        return;
      }

      final newProduct = AssetModel(
        image: _selectedImage!.path,
        name: _nameController.text,
        price: _priceController.text,
        quantity: _quantityController.text,
        total: _typeController.text,
      );
      Navigator.pop(context, newProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Asset'),
      ),
      body: AppPaddingWidget(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _selectedImage == null
                        ? Center(child: Text('Pick Picture'))
                        : Image.file(_selectedImage!, fit: BoxFit.cover),
                  ),
                ),
                verticalSpace(20.h),
                AppTextField(
                  controller: _nameController,
                  hintText: 'Name',
                  validator: (value) => value!.trim().isEmpty ? 'Please Enter Valid Name' : null,
                ),
                verticalSpace(20.h),
                AppTextField(
                  controller: _priceController,
                  hintText: 'Price',
                  validator: (value) => value!.trim().isEmpty ? 'Please Enter Valid Price' : null,
                ),
                verticalSpace(20.h),
                AppTextField(
                  controller: _quantityController,
                  hintText: 'Quantity',
                  validator: (value) => value!.isEmpty ? 'Please Enter Valid Quantity' : null,
                ),
                verticalSpace(20.h),
                AppTextField(
                  controller: _typeController,
                  hintText: 'Total',
                  validator: (value) => value!.isEmpty ? 'Please Enter Valid Total' : null,
                ),
                verticalSpace(20.h),
                AppButton(
                  onPressed: () => _addProduct(context),
                  text: 'Add New Asset',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
