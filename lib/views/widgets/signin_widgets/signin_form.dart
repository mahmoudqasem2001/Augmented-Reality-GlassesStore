import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import '../../../providers/auth.dart';
import '../../../shared/constants/constants.dart';
import '../../screens/login_screens/login_success_screen.dart';
import '../auth_common_widgets/form_error.dart';


class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
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

      final authProvider = Provider.of<Auth>(context, listen: false);

    authProvider.setLoadingIndicator(true);
    String message = " ";
    await Provider.of<Auth>(context, listen: false)
        .login(email: _emailController.text, password: _passwordController.text)
        .then((value) => message = value);

    if (message != "success") {
      _showErrorDialog(message);
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.redAccent,
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
                  Radio<String>(
                      value: 'customer',
                      groupValue: userType,
                      onChanged: (String? type) {
                        setState(() {
                          userType = type!;
                        });
                      }),
                ],
              ),
              Column(
                children: [
                  Text("Store"),
                  Radio<String>(
                      value: 'store',
                      groupValue: userType,
                      onChanged: (String? type) {
                        setState(() {
                          userType = type!;
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
                if (userType == 'customer') {
                  auth
                      .fetchCustomerAccountInfo()
                      .then((value) => auth.setAuthentucated(value));
                } else if (userType == 'store') {
                  auth
                      .fetchStoreAccountInfo()
                      .then((value) => auth.setAuthentucated(value));
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
