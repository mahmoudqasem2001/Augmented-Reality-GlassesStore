import 'package:flutter/material.dart';
import 'package:shop_app/views/screens/home_screens/home_screen.dart';
import 'package:shop_app/views/widgets/stores_widgets/stores_grid.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);
  static const routeName = '/stores';
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },
        ),
      ),
      body: const StoresGrid(),
    );
  }
}
