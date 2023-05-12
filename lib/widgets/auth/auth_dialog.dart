import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/login_screen.dart';
import 'package:shop_app/screens/auth/signUp_screen.dart';
import 'package:shop_app/screens/home/product_overview_screen.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Welcome Friend',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      shadowColor: Colors.black,
      content: SizedBox(
        height: 250,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "You should have an account",
              style: TextStyle(color: Colors.grey.shade700),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.grey.shade700),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                },
                child: Text(
                  'SIGNUP',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
