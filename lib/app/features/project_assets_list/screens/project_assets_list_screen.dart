import 'dart:io';

import 'package:enjaz_app/core/models/assets_project.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../add_project_assets/screens/add_project_assets_screen.dart';
import '../../create_project/controller/project_controller.dart';

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

class ProjectAssetsListScreen extends StatefulWidget {
  @override
  _ProjectAssetsListScreenState createState() => _ProjectAssetsListScreenState();
}

class _ProjectAssetsListScreenState extends State<ProjectAssetsListScreen> {
  final List<AssetModel> _productList = [];
  late ProjectController controller;
  @override
  void initState() {
    controller = Get.put(ProjectController());
    // controller.onInit();
    super.initState();
  }
  void _navigateToAddProduct(BuildContext context) async {
    final result = await Navigator.push(
    // final result = await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AddProjectAssetsScreen(),
      ),
    );
    print((result as AssetModel).total);
    if (result != null && result is AssetModel) {
      
      setState(() {
        _productList.add(result);
        controller.addAsset(XFile(result.image),
        name: result.name,
          quantity: result.quantity,
        price: num.tryParse(result.price),
          total: num.tryParse(result.total),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(controller.project?.assets?.firstOrNull?.toJson());
    print(_productList);
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Assets List'),
      ),
      body:
      (controller.project?.assets??[]).isEmpty
      // _productList.isEmpty
          ? Center(child: Text('No Assets😢'))
          : ListView.builder(
        itemCount:  (controller.project?.assets??[]).length,
        // itemCount: _productList.length,
        itemBuilder: (context, index) {
          final product =  (controller.project?.assets??[])[index];
          // final product = _productList[index];
          return ListTile(
            leading: Image.file(File(product.localUrl??"")),
            // leading: Image.asset(product.image),
            title: Text(product.name??"-"),
            // title: Text(product.name),
            subtitle: Text('Price: ${product.price??'-'} | Quantity: ${product.quantity??'-'}'),
            trailing: Text('Total: ${product.total??'-'}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddProduct(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
