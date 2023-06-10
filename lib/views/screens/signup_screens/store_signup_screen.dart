import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/home_provider.dart';
import '../../widgets/signup_widgets/store_signup_form.dart';

class StoreSignUpScreen extends StatelessWidget {
  StoreSignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signUp';

  @override
  Widget build(BuildContext context) {
    var home = Provider.of<Home>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text(
          'Store Sign Up',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            home.setBottomBarSelectedIndex(2);
            Navigator.pop(context);
          },
        ),
      ),
      body: signUpBody(),
    );
  }

  SafeArea signUpBody() {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          shrinkWrap: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: const [
            SizedBox(
              height: 40,
            ),
            Text(
              'Complete Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Complete your details',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: StoreSignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}