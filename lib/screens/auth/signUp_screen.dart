import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../providers/general.dart';
import '../../widgets/auth/form_error.dart';
import '../../widgets/auth/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signUp';

  @override
  Widget build(BuildContext context) {
    var generalProvider = Provider.of<General>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
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
          children: [
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}

