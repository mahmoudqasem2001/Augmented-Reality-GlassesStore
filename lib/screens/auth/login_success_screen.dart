import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/home/product_overview_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({Key? key}) : super(key: key);
  static const routeName = '/login_success';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Success',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: 1200,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset('assets/images/login_success.png'),
          Text(
            'Login Success',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(HomeScreen.routeName);
              },
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                'Back to home',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
          ),
        ]),
      ),
    );
  }
}
