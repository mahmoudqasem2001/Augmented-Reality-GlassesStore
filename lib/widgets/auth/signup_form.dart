import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import '../../constants.dart';
import 'form_error.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  PhoneNumber? phoneNumber;
  String? address;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    final String policyTerms =
        'By signing in, you agree to Store Terms of Service \nand acknowledge that your personal information will be\n processed in accordance with Store Privacy Policy.';
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          buildConformPassFormField(),
          SizedBox(height: 30),
          buildPhoneNumberFormField(),
          SizedBox(height: 20),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: 40),
          Text(
            policyTerms,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 30,
          ),
          submitSignUpButton(),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.key,
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.key,
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kEmailInvalidError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kEmailInvalidError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildPhoneNumberFormField() {
    return IntlPhoneField(
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.phone),
        labelText: 'Phone Number',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      initialCountryCode: 'PS',
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.toString().isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.toString().isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_on),
      ),
    );
  }

  Widget submitSignUpButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: MaterialButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
            }
            
             Navigator.of(context).pushNamed(HomeScreen.routeName);
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
