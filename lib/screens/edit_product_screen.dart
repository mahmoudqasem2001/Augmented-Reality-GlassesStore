import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key key}) : super(key: key);
  static const routeName = '/edit-product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit product screen"),
      ),
      body: Center(child: Text("edit product screen")),
    );
  }
}
