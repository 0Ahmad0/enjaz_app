import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:flutter/material.dart';

import '../../add_project_assets/screens/add_project_assets_screen.dart';

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

  void _navigateToAddProduct(BuildContext context) async {
    final result = await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AddProjectAssetsScreen(),
      ),
    );

    if (result != null && result is AssetModel) {
      setState(() {
        _productList.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_productList);
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Assets List'),
      ),
      body: _productList.isEmpty
          ? Center(child: Text('No Assets😢'))
          : ListView.builder(
        itemCount: _productList.length,
        itemBuilder: (context, index) {
          final product = _productList[index];
          return ListTile(
            leading: Image.asset(product.image),
            title: Text(product.name),
            subtitle: Text('Price: ${product.price} | Quantity: ${product.quantity}'),
            trailing: Text('Total: ${product.total}'),
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
