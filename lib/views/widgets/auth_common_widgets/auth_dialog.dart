import 'package:flutter/material.dart';
import 'package:shop_app/views/screens/login_screens/login_screen.dart';
import 'package:shop_app/views/screens/signup_screens/customer_signup_screen.dart';

import '../../screens/signup_screens/store_signup_screen.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: const Text(
        'Welcome Friend!',
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
              "You should login to your account",
              style: TextStyle(color: Colors.grey.shade700),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: MaterialButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                color: Theme.of(context).colorScheme.primary,
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.grey.shade700),
            ),
            Text(
              "Sign up as",
              style: TextStyle(color: Colors.grey.shade700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CustomerSignUpScreen.routeName);
                    },
                    color: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'Customer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 10),
                    onPressed: () {
                      Navigator.of(context).pushNamed(StoreSignUpScreen.routeName);
                    },
                    color: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'Store',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
