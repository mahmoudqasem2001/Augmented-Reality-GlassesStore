import 'package:flutter/material.dart';
import 'package:shop_app/widgets/app_drawer.dart';


class ProductOverViewScreen extends StatefulWidget {
  const ProductOverViewScreen({Key key}) : super(key: key);

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop"),),
      body: Center(child: Text("Text")),
      drawer: AppDrawer(),
    );
  }
}