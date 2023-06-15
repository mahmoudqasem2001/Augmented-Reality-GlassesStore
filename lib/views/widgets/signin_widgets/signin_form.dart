import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import '../../../providers/auth.dart';
import '../../../shared/constants/constants.dart';
import '../../screens/login_screens/login_success_screen.dart';
import '../auth_common_widgets/form_error.dart';

//enum User { customer, store }

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  User _userType = User.customer;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String password = '';
  final List<String> errors = [];

  _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      Provider.of<Auth>(context, listen: false).setLoadingIndicator(false);
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();

    try {
      final authProvider = Provider.of<Auth>(context, listen: false);
      authProvider.setLoadingIndicator(true);
      await authProvider
          .login(
              email: _emailController.text, password: _passwordController.text)
          .then((value) => authProvider.setAuthentucated(value));
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXIST')) {
        errorMessage = 'This email address is already use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(errorMessage),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('okey!')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Customer"),
                  Radio<User>(
                      value: User.customer,
                      groupValue: _userType,
                      onChanged: (User? userType) {
                        setState(() {
                          _userType = userType!;
                        });
                      }),
                ],
              ),
              Column(
                children: [
                  Text("Store"),
                  Radio<User>(
                      value: User.store,
                      groupValue: _userType,
                      onChanged: (User? userType) {
                        setState(() {
                          _userType = userType!;
                        });
                      }),
                ],
              ),
            ],
          )),
          SizedBox(
            height: 40,
          ),
          buildEmailFormField(),
          const SizedBox(
            height: 20,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: 20,
          ),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 10,
          borderSide: const BorderSide(color: Colors.black),
        ),
        suffixIcon: const Icon(Icons.mail),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Email must not be empty";
        } else if (!value.contains('@')) {
          return "Please enter a valid email";
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black),
          gapPadding: 10,
        ),
        suffixIcon: const Icon(Icons.key),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 10,
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password must not be empty";
        } else if (value.length < 8) {
          return "Password must be more than 7 charactars";
        }
        return null;
      },
    );
  }

  Widget submitSignInButton() {
    return Consumer<Auth>(builder: (_, auth, ch) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: MaterialButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              await _submit(context);
              final cartProvider = Provider.of<Cart>(context, listen: false);
              if (auth.authenticated == true) {
                auth.setLoadingIndicator(false);
                if (_userType == User.customer) {
                  auth
                      .fetchCustomerAccountInfo()
                      .then((value) => auth.setAuthentucated(value));
                  auth.setUserType(_userType);
                } else if (_userType == User.store) {
                  auth
                      .fetchStoreAccountInfo()
                      .then((value) => auth.setAuthentucated(value));
                  auth.setUserType(_userType);
                }
                cartProvider.fetchCartItems();
                Navigator.of(context)
                    .pushReplacementNamed(LoginSuccessScreen.routeName);
              }
            },
            minWidth: 200,
            height: 50,
            color: Colors.black,
            child: Consumer<Auth>(
              builder: (_, auth, child) {
                return auth.isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      );
              },
            ),
          ),
        ),
      );
    });
  }
}
