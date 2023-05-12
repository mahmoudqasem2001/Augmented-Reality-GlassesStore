import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/auth/login_success_screen.dart';
import 'package:shop_app/widgets/auth/form_error.dart';

import '../../providers/general.dart';
import '../../widgets/auth/signin_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    var generalProvider = Provider.of<General>(context, listen: false);

    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontSize: 16,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            generalProvider.setSelectedIndex(2);
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
          children: [
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
              padding: const EdgeInsets.symmetric(
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
