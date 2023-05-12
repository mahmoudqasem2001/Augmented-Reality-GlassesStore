import 'package:flutter/material.dart';
import 'package:shop_app/widgets/home/products_filters.dart';

class EndDrawer extends StatelessWidget {
  //final List<String> options;
  String gender = 'Gender';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all( 16),
            child: Text(
              'Filters',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, ),
            ),
          ),
          ProductFilterWidget(),
        ],
      ),
    );
  }
}
