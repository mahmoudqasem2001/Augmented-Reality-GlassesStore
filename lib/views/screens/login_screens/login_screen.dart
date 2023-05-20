import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/home_provider.dart';
import '../../widgets/login_widgets/signin_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  

  @override
  Widget build(BuildContext context) {
    var home = Provider.of<Home>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text(
          'Sign In',
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
      body: signInBody(),
    );
  }

  SafeArea signInBody() {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          shrinkWrap: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: const [
            SizedBox(
              height: 90,
            ),
            Text(
              'Welcome Back',
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
              'Sign in with your email and password',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SignForm(),
            ),
          ],
        ),
      ),
    );
  }
}
