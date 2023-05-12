import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../screens/auth/login_success_screen.dart';
import 'form_error.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: 20,
          ),
          buildPasswordFormField(),
          FormError(errors: errors),
          submitSignInButton(),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black),
          gapPadding: 10,
        ),
        
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 10,
          borderSide: BorderSide(color: Colors.black),
        ),
        suffixIcon: Icon(Icons.mail),
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kEmailInvalidError)) {
          setState(() {
            errors.remove(kEmailInvalidError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kEmailInvalidError)) {
          setState(() {
            errors.add(kEmailInvalidError);
          });
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black),
          gapPadding: 10,
        ),
        suffixIcon: Icon(Icons.key),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 10,
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      onSaved: (newValue) => password != newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
        }
        return null;
      },
    );
  }

  Widget submitSignInButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: MaterialButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
            }
            Navigator.of(context).pushNamed(LoginSuccessScreen.routeName);
          },
          child: Text(
            'Continue',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          minWidth: 200,
          height: 50,
          color: Colors.black,
        ),
      ),
    );
  }
}
