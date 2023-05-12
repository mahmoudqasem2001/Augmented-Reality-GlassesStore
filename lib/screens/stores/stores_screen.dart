import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/widgets/stores/stores_grid.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);
  static const routeName = '/stores';
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stores',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },
        ),
      ),
      body: StoresGrid(),
    );
  }
}
