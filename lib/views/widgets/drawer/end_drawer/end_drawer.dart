import 'package:flutter/material.dart';
import 'package:shop_app/views/widgets/drawer/end_drawer/products_filters.dart';

class EndDrawer extends StatelessWidget {

  const EndDrawer({Key? key}) : super(key: key);

 final String gender = 'Gender';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      width: 250,
      child: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all( 16),
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
